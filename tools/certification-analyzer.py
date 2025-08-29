#!/usr/bin/env python3
"""
NubemClaude Framework - Cable Certification Analyzer
Análisis inteligente de certificaciones de cableado UTP y fibra óptica
"""

import json
import re
from dataclasses import dataclass
from typing import List, Dict, Optional
from enum import Enum

class Severity(Enum):
    PASS = "PASS"
    WARNING = "WARNING"
    FAIL = "FAIL"
    CRITICAL = "CRITICAL"

@dataclass
class CableTest:
    parameter: str
    value: float
    unit: str
    limit: float
    result: str
    margin: Optional[float] = None

@dataclass
class Finding:
    severity: Severity
    parameter: str
    issue: str
    probable_cause: str
    recommendation: str
    impact: Optional[str] = None

class CableCertificationAnalyzer:
    
    def __init__(self):
        self.cat6_limits = {
            'insertion_loss_100MHz': 18.5,  # dB permanent link
            'next_100MHz': 35.1,  # dB
            'ps_next_100MHz': 32.1,  # dB
            'return_loss_100MHz': 10.0,  # dB
            'length': 90.0,  # meters permanent link
            'delay_skew': 50.0,  # nanoseconds
            'propagation_delay': 555.0  # nanoseconds @ 100m
        }
        
        self.cat6a_limits = {
            'insertion_loss_500MHz': 45.3,  # dB permanent link
            'next_500MHz': 60.0,  # dB
            'ps_next_500MHz': 57.0,  # dB
            'return_loss_500MHz': 8.0,  # dB
            'acr_f_500MHz': 17.4,  # dB (FEXT)
            'length': 90.0,  # meters
            'delay_skew': 50.0,  # nanoseconds
        }
        
        self.fiber_limits = {
            'om3_10g_sr': {'max_length': 300, 'max_loss': 2.6},  # meters, dB
            'om4_10g_sr': {'max_length': 400, 'max_loss': 2.6},
            'om4_40g_sr4': {'max_length': 150, 'max_loss': 1.9},
            'om4_100g_sr4': {'max_length': 100, 'max_loss': 1.9},
        }
    
    def analyze_copper_certification(self, test_results: Dict) -> List[Finding]:
        """Analiza certificación de cableado de cobre"""
        findings = []
        
        # Determinar categoría
        category = self._detect_cable_category(test_results)
        limits = self.cat6_limits if category == 'Cat6' else self.cat6a_limits
        
        # Análizar cada parámetro
        for param, limit in limits.items():
            if param in test_results:
                finding = self._analyze_parameter(param, test_results[param], limit)
                if finding:
                    findings.append(finding)
        
        # Análisis de patrones
        findings.extend(self._analyze_patterns(test_results))
        
        return findings
    
    def analyze_fiber_certification(self, test_results: Dict) -> List[Finding]:
        """Analiza certificación de fibra óptica"""
        findings = []
        
        # Análisis básico Tier 1
        if 'insertion_loss' in test_results:
            finding = self._analyze_fiber_loss(test_results)
            if finding:
                findings.append(finding)
        
        # Análisis OTDR si disponible
        if 'otdr_trace' in test_results:
            findings.extend(self._analyze_otdr_trace(test_results['otdr_trace']))
        
        return findings
    
    def _detect_cable_category(self, test_results: Dict) -> str:
        """Detecta la categoría del cable basado en frecuencias de test"""
        if any('500' in str(key) for key in test_results.keys()):
            return 'Cat6A'
        return 'Cat6'
    
    def _analyze_parameter(self, param: str, value: float, limit: float) -> Optional[Finding]:
        """Analiza un parámetro individual"""
        
        # Parámetros donde más es mejor (NEXT, Return Loss)
        higher_is_better = ['next', 'return_loss', 'ps_next', 'acr_f']
        is_higher_better = any(h in param.lower() for h in higher_is_better)
        
        if is_higher_better:
            margin = value - limit
            if margin < 0:
                return Finding(
                    severity=Severity.FAIL,
                    parameter=param,
                    issue=f"Valor {value:.1f}{self._get_unit(param)} por debajo del límite {limit:.1f}",
                    probable_cause=self._get_probable_cause_fail(param),
                    recommendation=self._get_recommendation(param, 'fail'),
                    impact="Enlace no certificado, posibles errores de transmisión"
                )
            elif margin < 3:
                return Finding(
                    severity=Severity.WARNING,
                    parameter=param,
                    issue=f"Margen bajo: {margin:.1f}dB",
                    probable_cause="Instalación al límite de especificación",
                    recommendation=self._get_recommendation(param, 'warning'),
                    impact="Funcionará pero sin margen de seguridad"
                )
        else:
            # Parámetros donde menos es mejor (Insertion Loss, Length)
            margin = limit - value
            if margin < 0:
                return Finding(
                    severity=Severity.FAIL,
                    parameter=param,
                    issue=f"Valor {value:.1f}{self._get_unit(param)} excede límite {limit:.1f}",
                    probable_cause=self._get_probable_cause_fail(param),
                    recommendation=self._get_recommendation(param, 'fail'),
                    impact="Enlace fuera de especificación"
                )
            elif margin < 3 and 'loss' in param.lower():
                return Finding(
                    severity=Severity.WARNING,
                    parameter=param,
                    issue=f"Margen bajo: {margin:.1f}dB",
                    probable_cause="Conectores o cable de calidad marginal",
                    recommendation="Limpiar conectores, verificar terminaciones",
                    impact="Margen insuficiente para degradación futura"
                )
        
        return None
    
    def _analyze_patterns(self, test_results: Dict) -> List[Finding]:
        """Analiza patrones en los resultados"""
        findings = []
        
        # Detectar problemas sistemáticos
        fail_count = sum(1 for v in test_results.values() 
                        if isinstance(v, dict) and v.get('result') == 'FAIL')
        
        if fail_count >= 3:
            findings.append(Finding(
                severity=Severity.CRITICAL,
                parameter="Sistema",
                issue="Múltiples parámetros fallando",
                probable_cause="Error sistemático en instalación o cable defectuoso",
                recommendation="Revisar proceso de instalación completo",
                impact="Enlace completamente inadecuado para uso"
            ))
        
        # Detectar split pairs por patrón NEXT
        if self._detect_split_pairs(test_results):
            findings.append(Finding(
                severity=Severity.CRITICAL,
                parameter="Wire Map",
                issue="Posible split pair detectado",
                probable_cause="Error en secuencia de pines durante conectorización",
                recommendation="Reconectorizar siguiendo T568A o T568B consistentemente",
                impact="Alto crosstalk, enlace inestable"
            ))
        
        return findings
    
    def _analyze_fiber_loss(self, test_results: Dict) -> Optional[Finding]:
        """Analiza pérdida de inserción en fibra"""
        loss = test_results.get('insertion_loss', 0)
        length_km = test_results.get('length', 0) / 1000
        connector_count = test_results.get('connectors', 2)
        splice_count = test_results.get('splices', 0)
        
        # Calcular límite esperado
        expected_loss = (
            0.75 +  # Margen base
            (length_km * 3.5) +  # Fibra @ 3.5dB/km
            (connector_count * 0.3) +  # Conectores
            (splice_count * 0.1)  # Empalmes
        )
        
        margin = expected_loss - loss
        
        if margin < 0:
            return Finding(
                severity=Severity.FAIL,
                parameter="Insertion Loss",
                issue=f"Pérdida {loss:.2f}dB excede límite calculado {expected_loss:.2f}dB",
                probable_cause="Conectores sucios, empalmes defectuosos o fibra dañada",
                recommendation="Limpiar conectores con alcohol isopropílico, verificar empalmes",
                impact="Enlace puede no funcionar en todas las condiciones"
            )
        elif margin < 1:
            return Finding(
                severity=Severity.WARNING,
                parameter="Insertion Loss",
                issue=f"Margen bajo: {margin:.2f}dB",
                probable_cause="Conectores marginales o envejecimiento",
                recommendation="Limpiar conectores, considerar reemplazo preventivo",
                impact="Enlace funcionará pero con poco margen"
            )
        
        return None
    
    def _analyze_otdr_trace(self, otdr_data: List[Dict]) -> List[Finding]:
        """Analiza traza OTDR"""
        findings = []
        
        for event in otdr_data:
            loss = event.get('loss', 0)
            reflectance = event.get('reflectance', 0)
            event_type = event.get('type', 'unknown')
            
            if event_type == 'connector' and loss > 0.5:
                findings.append(Finding(
                    severity=Severity.WARNING,
                    parameter="OTDR Connector",
                    issue=f"Pérdida conector {loss:.2f}dB a {event.get('distance')}m",
                    probable_cause="Conector sucio o mal pulido",
                    recommendation="Limpiar conector con procedimiento estándar",
                    impact="Degradación de señal"
                ))
            
            if event_type == 'splice' and loss > 0.1:
                findings.append(Finding(
                    severity=Severity.WARNING,
                    parameter="OTDR Splice",
                    issue=f"Pérdida empalme {loss:.2f}dB a {event.get('distance')}m",
                    probable_cause="Empalme de fusión defectuoso",
                    recommendation="Revisar parámetros de fusionadora",
                    impact="Pérdida de potencia óptica"
                ))
        
        return findings
    
    def _detect_split_pairs(self, test_results: Dict) -> bool:
        """Detecta split pairs por patrón anómalo en NEXT"""
        # Lógica simplificada - en implementación real sería más compleja
        next_values = [v for k, v in test_results.items() if 'next' in k.lower()]
        if len(next_values) >= 4:
            # Si hay variación excesiva entre pares, posible split pair
            return max(next_values) - min(next_values) > 10
        return False
    
    def _get_unit(self, param: str) -> str:
        """Obtiene la unidad de medida del parámetro"""
        if 'loss' in param.lower() or 'next' in param.lower():
            return 'dB'
        elif 'length' in param.lower():
            return 'm'
        elif 'delay' in param.lower():
            return 'ns'
        return ''
    
    def _get_probable_cause_fail(self, param: str) -> str:
        """Obtiene la causa probable de fallo"""
        causes = {
            'insertion_loss': "Cable de baja calidad, conectores defectuosos, longitud excesiva",
            'next': "Destrenzado excesivo, split pairs, cable aplastado",
            'return_loss': "Mezcla de categorías, conectores incompatibles, impedancia incorrecta",
            'length': "Medición incorrecta o enlace realmente largo",
            'delay_skew': "Pares de longitudes muy diferentes, cable defectuoso"
        }
        
        for key, cause in causes.items():
            if key in param.lower():
                return cause
        return "Instalación incorrecta o componente defectuoso"
    
    def _get_recommendation(self, param: str, severity: str) -> str:
        """Obtiene recomendación específica"""
        if severity == 'fail':
            recommendations = {
                'insertion_loss': "Verificar longitud real, reemplazar cable por Cat superior",
                'next': "Reconectorizar respetando destrenzado <13mm, verificar no hay split pairs",
                'return_loss': "Usar componentes de misma categoría, verificar impedancia",
                'length': "Acortar enlace o dividir en dos segmentos"
            }
        else:  # warning
            recommendations = {
                'insertion_loss': "Limpiar conectores, verificar no hay aplastamientos",
                'next': "Revisar terminaciones, alejar de fuentes interferencia",
                'return_loss': "Limpiar conectores, verificar no hay empalmes"
            }
        
        for key, rec in recommendations.items():
            if key in param.lower():
                return rec
        return "Revisar instalación según mejores prácticas"
    
    def generate_report(self, findings: List[Finding]) -> Dict:
        """Genera reporte estructurado"""
        
        # Contar severidades
        severity_count = {s: 0 for s in Severity}
        for finding in findings:
            severity_count[finding.severity] += 1
        
        # Determinar estado general
        if severity_count[Severity.FAIL] > 0 or severity_count[Severity.CRITICAL] > 0:
            overall_status = "FAIL"
        elif severity_count[Severity.WARNING] > 0:
            overall_status = "PASS*"
        else:
            overall_status = "PASS"
        
        return {
            "overall_status": overall_status,
            "summary": {
                "total_issues": len(findings),
                "critical": severity_count[Severity.CRITICAL],
                "fail": severity_count[Severity.FAIL],
                "warning": severity_count[Severity.WARNING],
                "pass": severity_count[Severity.PASS]
            },
            "findings": [
                {
                    "severity": f.severity.value,
                    "parameter": f.parameter,
                    "issue": f.issue,
                    "probable_cause": f.probable_cause,
                    "recommendation": f.recommendation,
                    "impact": f.impact
                }
                for f in findings
            ],
            "executive_summary": self._generate_executive_summary(overall_status, findings)
        }
    
    def _generate_executive_summary(self, status: str, findings: List[Finding]) -> str:
        """Genera resumen ejecutivo"""
        if status == "PASS":
            return "✅ Certificación EXITOSA. El enlace cumple todas las especificaciones con márgenes adecuados. Apto para aplicaciones de alta velocidad."
        
        elif status == "PASS*":
            critical_issues = [f for f in findings if f.severity in [Severity.WARNING, Severity.CRITICAL]]
            return f"⚠️ Certificación CONDICIONAL. El enlace funciona pero tiene {len(critical_issues)} problemas que requieren atención para garantizar operación a largo plazo."
        
        else:
            fail_issues = [f for f in findings if f.severity in [Severity.FAIL, Severity.CRITICAL]]
            return f"❌ Certificación FALLIDA. {len(fail_issues)} problemas críticos detectados. El enlace requiere corrección antes de puesta en servicio."

# Ejemplo de uso
def example_analysis():
    """Ejemplo de análisis de certificación"""
    
    analyzer = CableCertificationAnalyzer()
    
    # Ejemplo cobre marginal
    copper_results = {
        'insertion_loss_100MHz': 17.8,  # Cerca del límite 18.5
        'next_100MHz': 36.2,  # Margen bajo vs 35.1 límite
        'return_loss_100MHz': 12.5,  # OK
        'length': 89.5,  # Muy cerca de 90m
        'wire_map': 'PASS'
    }
    
    findings = analyzer.analyze_copper_certification(copper_results)
    report = analyzer.generate_report(findings)
    
    print("=== ANÁLISIS DE CERTIFICACIÓN ===")
    print(f"Estado: {report['overall_status']}")
    print(f"Resumen: {report['executive_summary']}")
    print()
    
    for finding in findings:
        print(f"🔍 {finding.parameter}: {finding.issue}")
        print(f"   Causa probable: {finding.probable_cause}")
        print(f"   Recomendación: {finding.recommendation}")
        print()

if __name__ == "__main__":
    example_analysis()