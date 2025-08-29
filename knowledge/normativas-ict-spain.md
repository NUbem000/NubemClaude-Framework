# Base de Conocimiento: Normativas ICT España

## 📋 Real Decreto 346/2011 - Reglamento ICT2

### Ámbito de Aplicación
- **Obligatorio**: Edificios nuevos con división horizontal
- **Viviendas**: A partir de 1 vivienda
- **Locales/Oficinas**: A partir de 5 locales
- **Excepciones**: Viviendas unifamiliares aisladas

### Servicios que debe soportar
1. **RTV** - Radio y Televisión (TDT + Radio FM/DAB)
2. **Cable** - Telecomunicaciones por cable (HFC/Fibra)
3. **Telefonía** - Acceso telefónico básico y RDSI
4. **Banda Ancha** - Fibra óptica hasta el hogar (FTTH)

### Elementos de la ICT

#### RITI (Recinto de Instalaciones de Telecomunicaciones Inferior)
```yaml
ubicacion: "Planta baja o sótano"
dimensiones_minimas:
  hasta_20_paus: "2000x2000x500mm"
  hasta_30_paus: "2000x2500x500mm"
  hasta_45_paus: "2000x3000x500mm"
  mas_45_paus: "2300x2000x2000mm (recinto)"
  
equipamiento:
  - Sistema de escalerilla o canaleta (30x10cm)
  - Cuadro de protección eléctrica
  - Alumbrado normal y emergencia (300 lux)
  - Tomas de corriente (mínimo 4)
  - Toma de tierra <10Ω
  - Ventilación natural o forzada
  
acceso:
  - Puerta 80x180cm mínimo
  - Cerradura con llave
  - Apertura hacia exterior
```

#### RITS (Recinto de Instalaciones de Telecomunicaciones Superior)
```yaml
ubicacion: "Azotea o bajo cubierta"
dimensiones_minimas:
  hasta_20_paus: "2000x2000x500mm"
  hasta_30_paus: "2000x2500x500mm"
  hasta_45_paus: "2000x3000x500mm"
  mas_45_paus: "2300x2000x2000mm (recinto)"

equipamiento:
  - Bases de anclaje para mástiles
  - Sistema de escalerilla (30x10cm)
  - Cuadro eléctrico con diferencial
  - Iluminación 300 lux
  - Tomas corriente (mínimo 2)
  - Punto acceso equipotencial
  
proteccion:
  - Impermeabilización completa
  - Protección contra rayos
  - Ventilación adecuada
```

### Canalizaciones

#### Canalización Principal
```yaml
tramos:
  riti_a_rits:
    tubos_minimos: 5
    diametro: 50mm
    material: PVC rígido
    
  capacidad_segun_paus:
    hasta_12: "5 tubos Ø50"
    13_a_20: "6 tubos Ø50"
    21_a_30: "7 tubos Ø50"
    
distribucion_tubos:
  cable_hfc: 1
  cable_pares: 1
  fibra_optica: 2
  reserva: 1
  rtv: 1
```

#### Canalización Secundaria
```yaml
desde: "Registro secundario"
hasta: "Registro de terminación de red"

tubos_minimos: 3
diametro: 25mm

distribucion:
  cable_pares: 1
  cable_coaxial: 1
  fibra_optica: 1
```

#### Canalización Interior
```yaml
desde: "RTR"
hasta: "Registros de toma"

configuracion_estrella:
  tubos_minimos: 3
  diametro: 20mm
  
hasta_cada_toma:
  - 1 tubo cable pares
  - 1 tubo cable coaxial
  - 1 tubo reserva/fibra
```

### Registros

#### Registro Principal
```yaml
ubicacion: "RITI o RITS"
dimensiones:
  tipo_a: "360x360x120mm"
  tipo_b: "500x500x150mm"
  tipo_c: "550x1000x150mm"
```

#### Registro Secundario
```yaml
ubicacion: "Cada planta"
dimensiones:
  hasta_20_paus: "450x450x150mm"
  20_a_30_paus: "500x700x150mm"
  mas_30_paus: "550x1000x150mm"
```

#### RTR (Registro Terminación Red)
```yaml
ubicacion: "Interior vivienda/local"
dimensiones: "300x500x60mm"
ubicacion_tipica: "Entrada vivienda"
altura: "200-2300mm del suelo"
```

#### Registros de Toma
```yaml
dimensiones: "64x64x42mm"
altura_instalacion: "200-2300mm"
distancia_esquinas: ">100mm"
```

### Cableado Mínimo

#### Par Trenzado
- **Cable**: UTP Cat.6 mínimo
- **Tomas por vivienda**: 1 por estancia (mínimo 2)
- **Conectorización**: RJ45
- **Certificación**: Obligatoria

#### Cable Coaxial
- **Tipo**: RG-6 o superior
- **Impedancia**: 75Ω
- **Atenuación**: <20dB a 860MHz
- **Tomas**: 1 por estancia habitable

#### Fibra Óptica
- **Tipo**: G.657 categoría A2 o B3
- **Fibras**: 2 FO por vivienda mínimo
- **Conectores**: SC/APC
- **Atenuación**: <0.4dB/km a 1310nm

## 📊 Cálculos ICT

### Número de PAUs
```python
def calcular_paus(viviendas, locales, oficinas):
    """Cálculo de Puntos de Acceso al Usuario"""
    paus = viviendas + locales + oficinas
    
    # Factor de reserva
    if paus <= 20:
        reserva = int(paus * 0.2)
    else:
        reserva = int(paus * 0.15)
    
    return paus + max(reserva, 2)
```

### Dimensionamiento Registros
```python
def dimensionar_registro_secundario(paus_planta):
    """Dimensiones registro secundario según PAUs"""
    if paus_planta <= 20:
        return "450x450x150mm"
    elif paus_planta <= 30:
        return "500x700x150mm"
    else:
        return "550x1000x150mm"
```

## 🔧 Proceso de Legalización

### 1. Proyecto Técnico
- Redactado por ingeniero telecomunicaciones
- Visado por colegio profesional
- Incluye memoria, planos, pliego, presupuesto

### 2. Ejecución
- Por instalador telecomunicaciones habilitado
- Seguimiento dirección de obra
- Certificaciones parciales

### 3. Certificación
- Boletín de instalación
- Protocolo de pruebas
- Certificado fin de obra

### 4. Documentación Final
```yaml
documentos:
  - Proyecto técnico visado
  - Anexo servicios instalados
  - Boletín instalación
  - Protocolo pruebas:
      - Continuidad
      - Aislamiento
      - NEXT/FEXT
      - Atenuación
      - Return Loss
  - Certificado fin obra
  - Planos as-built
```

## 🏢 Aplicación a Hoteles

### Consideraciones Especiales
```yaml
hoteles:
  tratamiento: "Como edificio residencial"
  
  paus_calculo:
    habitaciones: 1 PAU por habitación
    suites: 2 PAUs por suite
    zonas_comunes: 1 PAU por zona
    oficinas: 1 PAU por puesto
    
  servicios_adicionales:
    - IPTV profesional
    - WiFi alta densidad
    - Telefonía IP
    - Domótica/BMS
    - CCTV IP
    
  certificaciones_extra:
    - Fluke DTX cableado
    - Ekahau/AirMagnet WiFi
    - OTDR fibra óptica
```

## ⚖️ Sanciones

### Infracciones
```yaml
muy_graves:
  - No ejecutar ICT
  - Incumplimiento seguridad
  sancion: "600.001€ a 2.000.000€"
  
graves:
  - Proyecto sin visar
  - Instalador no habilitado
  sancion: "30.001€ a 600.000€"
  
leves:
  - Documentación incompleta
  - Retrasos injustificados
  sancion: "Hasta 30.000€"
```

## 📚 Normativa Relacionada

### Nacional
- **RD 346/2011**: Reglamento ICT2
- **Orden ITC/1644/2011**: Desarrollo del reglamento
- **RD 805/2014**: Plan técnico TDT
- **Ley 9/2014**: Ley General Telecomunicaciones

### Autonómica (varía por región)
- Decretos autonómicos ICT
- Ordenanzas municipales
- Normativa urbanística

### Técnica
- **UNE-EN 50173**: Cableado estructurado
- **UNE-EN 50174**: Instalación de cableado
- **UNE 133100**: Infraestructuras FTTH
- **ISO/IEC 11801**: Cableado telecomunicaciones

## 🔄 Actualizaciones Recientes

### 5G Ready (2022)
- Preinstalación para small cells
- Fibra adicional para backhaul
- Consideración DAS interior

### Sostenibilidad (2023)
- Eficiencia energética equipos
- Materiales reciclables
- Reducción residuos electrónicos

---

*Base de conocimiento actualizada para cumplimiento normativo ICT en proyectos de infraestructura*