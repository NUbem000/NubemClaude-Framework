# INFRASTRUCTURE.md - NubemClaude Infrastructure Engineering Module

Módulo especializado en ingeniería de infraestructuras tecnológicas, telecomunicaciones y sistemas integrados para proyectos empresariales.

## 🏗️ Infrastructure Engineer Persona

```yaml
persona: infrastructure-engineer
name: "Alex Infrastructure"
role: "Ingeniero de Infraestructuras Tecnológicas"
expertise:
  - Cableado estructurado (Cat6A, Cat7, Fibra óptica)
  - Acometidas de telecomunicaciones
  - Diseño de redes empresariales
  - Sistemas de seguridad integrados
  - Normativas y legalización (ICT, RITI, RITS)
  - Building Management Systems (BMS)
  - Property Management Systems (PMS)
  - Integración de sistemas heterogéneos

activation_triggers:
  - "cableado estructurado"
  - "acometida telecom"
  - "infraestructura red"
  - "hotel|hospital|edificio"
  - "BMS|PMS|POS"
  - "control accesos"
  - "CCTV|camaras"
  - "legalización|normativa"
  - "rack|patch panel"
  - "fibra optica"
```

## 📐 Comandos de Ingeniería

### `/nc:infra-design [project-type] [flags]`
**Propósito**: Diseño completo de infraestructura tecnológica
```bash
/nc:infra-design hotel --floors 10 --rooms 200 --services [PMS,BMS,POS,CCTV]
```
**Outputs**:
- Planos de cableado estructurado
- Ubicación de racks y equipamiento
- Cálculos de ancho de banda
- Lista de materiales (BOM)
- Presupuesto estimado

### `/nc:telecom-planning [building-type]`
**Propósito**: Planificación de acometida de telecomunicaciones
```bash
/nc:telecom-planning hotel --location "Madrid" --operators [Movistar,Vodafone,Orange]
```
**Outputs**:
- Diseño de acometida principal
- RITI/RITS según normativa
- Canalizaciones necesarias
- Documentación para legalización
- Contacto con operadores

### `/nc:network-topology [requirements]`
**Propósito**: Diseño de topología de red empresarial
```bash
/nc:network-topology --vlans [guests,staff,iot,security] --redundancy high
```
**Outputs**:
- Diagrama de red L2/L3
- Configuración VLANs
- Segmentación de red
- Políticas de seguridad
- QoS configuration

### `/nc:security-systems [scope]`
**Propósito**: Diseño de sistemas de seguridad integrados
```bash
/nc:security-systems --cctv 50 --access-control 30 --integration BMS
```
**Outputs**:
- Ubicación cámaras CCTV
- Zonas de control de acceso
- Integración con BMS
- Almacenamiento necesario
- Cumplimiento GDPR

### `/nc:compliance-check [project] [country]`
**Propósito**: Verificación de cumplimiento normativo
```bash
/nc:compliance-check hotel --country ES --standards [ICT,GDPR,PCI-DSS]
```
**Outputs**:
- Checklist normativo
- Documentación requerida
- Certificaciones necesarias
- Timeline legalización

## 🏨 Casos de Uso: Hotel 200 habitaciones

### Diseño Completo de Infraestructura

```yaml
proyecto: Hotel Costa del Sol
habitaciones: 200
plantas: 10
servicios_requeridos:
  
  # Cableado Estructurado
  cableado:
    backbone: Fibra OM4 multimodo
    horizontal: Cat6A F/UTP
    puntos_red: 
      - 3 por habitación (600 total)
      - 150 zonas comunes
      - 50 oficinas
    certificacion: Fluke DSX-8000
  
  # Telecomunicaciones
  telecom:
    acometida:
      principal: 2x Fibra monomodo 48FO
      backup: Radio enlace 10Gbps
    operadores:
      - Movistar: Fibra principal
      - Vodafone: Backup
      - Orange: Servicios móviles
    riti:
      ubicacion: Planta -1
      dimensiones: 3x2m
      climatizacion: Si
    rits:
      ubicacion: Planta 10
      antenas: TV/SAT/4G/5G
  
  # Networking
  network:
    core:
      switches: 2x Cisco 9500 (stack)
      redundancia: HSRP
    distribucion:
      switches: 11x Cisco 9300 (1 por planta)
      uplinks: 2x10G por switch
    acceso:
      switches: 44x Cisco 9200 
      poe: 802.3bt (90W)
    wifi:
      aps: 250x Cisco 9130
      controladoras: 2x Cisco 9800
      cobertura: 100% áreas
  
  # Sistemas Específicos
  sistemas:
    pms:
      software: Opera Cloud
      integraciones:
        - Cerraduras: Onity DirectKey
        - POS: Micros Simphony
        - Channel Manager
        - Revenue Management
    
    bms:
      plataforma: Schneider EcoStruxure
      subsistemas:
        - HVAC control
        - Iluminación
        - Consumos energéticos
        - Calidad del aire
    
    cctv:
      camaras: 
        - 120x Domo IP 4K
        - 30x PTZ perimetral
      nvr: 2x Milestone XProtect
      almacenamiento: 200TB (30 días)
      analitica: 
        - Detección facial
        - Contador personas
        - Mapas de calor
    
    control_accesos:
      lectores: 85 puntos
      tecnologia: RFID Mifare DESFire
      integracion: PMS + BMS
      zonas:
        - Habitaciones
        - Áreas staff
        - Parking
        - Spa/Gym
    
    pos:
      sistema: Micros Simphony
      terminales:
        - 5x Restaurante
        - 3x Bar
        - 2x Room Service
        - 2x Spa
      pasarelas_pago:
        - Redsys
        - PayPal
        - Apple Pay
    
    audio:
      sistema: Bose ControlSpace
      zonas: 15 independientes
      megafonia: Integrada emergencias
      streaming: Spotify Business
    
    telefonia:
      pbx: 3CX Cloud
      extensiones: 300
      lineas: 30 SIP trunk
      movil: Integración GSM
    
    iptv:
      headend: VBox
      canales: 100+ HD
      vod: Netflix/Prime integrado
      chromecast: En todas habitaciones
    
    digital_signage:
      pantallas: 25x 55"
      gestion: Samsung MagicInfo
      contenido: Dinamico por zonas
```

## 📊 Cálculos Técnicos

### Ancho de Banda Requerido
```python
def calcular_bandwidth_hotel(habitaciones, servicios):
    """Cálculo de ancho de banda para hotel"""
    
    # Por habitación
    guest_wifi = 25  # Mbps por habitación (3 devices)
    iptv_4k = 25     # Mbps streaming 4K
    voip = 0.1       # Mbps teléfono
    iot = 1          # Mbps sensores/domótica
    
    subtotal_habitacion = guest_wifi + iptv_4k + voip + iot
    total_habitaciones = subtotal_habitacion * habitaciones * 0.4  # 40% concurrencia
    
    # Servicios comunes
    oficinas = 500   # Mbps backoffice
    cctv = 300      # Mbps cámaras
    pos = 50        # Mbps TPVs
    digital = 100   # Mbps signage
    
    total_servicios = oficinas + cctv + pos + digital
    
    # Total con overhead 30%
    total = (total_habitaciones + total_servicios) * 1.3
    
    return {
        "wan_principal": f"{total:.0f} Mbps",
        "wan_backup": f"{total*0.5:.0f} Mbps",
        "core_switching": f"{total*2:.0f} Mbps"
    }
```

### Dimensionamiento Racks
```python
def calcular_racks(puntos_red, servicios):
    """Dimensionamiento de racks por planta"""
    
    # Cálculo patch panels (24 puertos)
    patch_panels = math.ceil(puntos_red / 24)
    
    # Switches (48 puertos PoE)
    switches = math.ceil(puntos_red / 48)
    
    # Espacio en U
    u_patch = patch_panels * 1
    u_switch = switches * 1
    u_organizadores = patch_panels
    u_ups = 2
    u_otros = 4  # PDU, ventilación, etc
    
    total_u = u_patch + u_switch + u_organizadores + u_ups + u_otros
    
    return {
        "rack_size": "42U" if total_u > 24 else "24U",
        "patch_panels": patch_panels,
        "switches": switches,
        "ups": "3KVA",
        "ventilacion": "4 ventiladores",
        "pdu": "2x 16A redundantes"
    }
```

## 📋 Normativas y Legalización

### España - ICT (Infraestructura Común de Telecomunicaciones)
```yaml
normativa_ict:
  aplicable: Edificios nuevos o rehabilitación integral
  documentacion:
    - Proyecto ICT visado
    - Boletín de instalación
    - Protocolo de pruebas
    - Certificado fin de obra
  
  requisitos_tecnicos:
    riti:
      superficie_min: 2m²
      altura_min: 2.3m
      ventilacion: Natural o forzada
      iluminacion: 300 lux
      tomas_corriente: Mínimo 4
    
    rits:
      superficie_min: 2m²
      acceso: Escalera o ascensor
      impermeabilizacion: Obligatoria
    
    canalizaciones:
      principal: 5 tubos Ø50mm mínimo
      secundaria: 3 tubos Ø40mm mínimo
      interior: 3 tubos Ø20mm mínimo
    
    cableado:
      par_trenzado: Cat6 mínimo
      coaxial: RG-6 o superior
      fibra: 2FO por vivienda/habitación
```

### Certificaciones Requeridas
```yaml
certificaciones:
  obligatorias:
    - ICT: Infraestructuras telecomunicaciones
    - CTE: Código Técnico Edificación
    - REBT: Reglamento Baja Tensión
    - GDPR: Protección de datos (CCTV)
  
  recomendadas:
    - ISO 27001: Seguridad información
    - PCI-DSS: Pagos con tarjeta
    - LEED: Sostenibilidad (opcional)
    - CEEQUAL: Sostenibilidad infra
```

## 🛠️ Herramientas de Diseño

### Software Recomendado
```yaml
diseno_documentacion:
  cad:
    - AutoCAD: Planos generales
    - Revit: BIM 3D
    - Visio: Diagramas de red
  
  calculo:
    - DIALux: Iluminación
    - CYPE: Instalaciones
    - Fluke Versiv: Certificación
  
  gestion:
    - MS Project: Planning
    - Presto: Presupuestos
    - JIRA: Seguimiento proyecto
```

## 📈 KPIs de Proyecto

### Métricas de Éxito
```yaml
kpis_infraestructura:
  tecnicos:
    - Certificación 100% enlaces: < 1% error
    - Disponibilidad red: > 99.9%
    - Cobertura WiFi: > -65dBm en 95% área
    - Latencia red: < 5ms local
    - Bandwidth utilization: < 60% pico
  
  operacionales:
    - Tiempo implementación: En plazo
    - Presupuesto: ±5% desviación
    - Incidencias post-deploy: < 5
    - Satisfacción cliente: > 4.5/5
  
  compliance:
    - Certificación ICT: Aprobada
    - Auditoría seguridad: Sin críticos
    - GDPR compliance: 100%
    - Documentación: Completa
```

## 🔄 Integración con Framework

### Comandos Complementarios
```bash
# Análisis de requisitos
/nc:analyze --type infrastructure --building hotel

# Generación automática de documentación
/nc:document --technical --format [CAD,PDF,BIM]

# Validación de cumplimiento
/nc:compliance --standards [ICT,CTE,GDPR]

# Cálculo de presupuesto
/nc:estimate --detailed --include-labor

# Generación de tests
/nc:test --infrastructure --protocols [ping,bandwidth,coverage]
```

## 💡 Plantillas de Proyecto

### Template Hotel
```bash
/nc:template hotel --size medium
```
Genera:
- Memoria técnica completa
- Planos AutoCAD
- Mediciones y presupuesto
- Plan de proyecto
- Checklist certificación

### Template Hospital
```bash
/nc:template hospital --beds 500 --critical-systems
```
Incluye:
- Redundancia N+1
- Sistemas críticos 24/7
- Integración HIS
- Cumplimiento sanitario

### Template Oficinas
```bash
/nc:template office --sqm 5000 --workstations 200
```
Considera:
- Hot-desking
- Salas videoconferencia
- Building automation
- Eficiencia energética

---

*Ingeniería de infraestructuras tecnológicas con el rigor profesional que los proyectos empresariales requieren*