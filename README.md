# 🚀 NubemClaude Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Compatible](https://img.shields.io/badge/Claude-Compatible-purple)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/NUbem000/NubemClaude-Framework)

**El framework definitivo para Claude Code**: Combina lo mejor de SuperClaude, RAG vectorial, y subagentes especializados en un sistema unificado y potente.

## 🌟 ¿Por qué NubemClaude Framework?

Este framework unifica las mejores características de múltiples proyectos exitosos:
- **Sistema modular de SuperClaude** - Arquitectura flexible y mantenible
- **RAG vectorial de NubemClaudeCode** - Memoria persistente inteligente
- **Subagentes de awesome-claude-code** - Especialización por dominio
- **Optimizaciones propias** - Mejoras de rendimiento y UX

## ✨ Características Principales

### 🧠 Sistema Inteligente Unificado
- **20+ Comandos especializados** con detección automática de contexto
- **15 Personas IA expertas** que se activan según el dominio
- **RAG con búsqueda vectorial** para memoria persistente
- **Wave Orchestration** para operaciones complejas multi-etapa
- **MCP Integration** completa (Context7, Sequential, Magic, Playwright)

### 🔄 Memoria y Contexto
- **Base vectorial Qdrant** para búsqueda semántica
- **PostgreSQL + pgvector** para búsquedas híbridas
- **Sincronización con GCP** para acceso multi-dispositivo
- **Rotación automática de API keys** cada 90 días
- **Cache inteligente** para optimización de tokens

### 🛠️ Herramientas de Productividad
- **CLI unificado** para gestión simple
- **Instalador inteligente** con detección de entorno
- **Templates de proyectos** para inicio rápido
- **Hooks personalizables** para automatización
- **Métricas y observabilidad** integradas

## 📦 Instalación

### Requisitos Previos
- Python 3.8+
- Node.js 18+
- Claude Code CLI instalado
- Cuenta Google Cloud (para RAG, opcional)

### Instalación Rápida

```bash
# Clonar el repositorio
git clone https://github.com/NUbem000/NubemClaude-Framework.git
cd NubemClaude-Framework

# Ejecutar instalador inteligente
./install.sh

# O usar el CLI
pip install nubemclaude
nubemclaude install
```

### Instalación Personalizada

```bash
# Elegir perfil de instalación
nubemclaude install --profile [minimal|standard|complete|enterprise]

# minimal: Solo comandos core (5 min)
# standard: Comandos + personas + MCP básico (10 min)
# complete: Todo excepto RAG (15 min)
# enterprise: Sistema completo con RAG + GCP (30 min)
```

## 🏗️ Arquitectura

```
┌─────────────────────────────────────────────────────┐
│                  NubemClaude Framework              │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────┐  ┌──────────────┐  ┌────────────┐│
│  │   Commands  │  │   Personas   │  │    MCP     ││
│  │  20+ cmds   │  │ 15 experts   │  │ 4 servers  ││
│  └──────┬──────┘  └──────┬───────┘  └─────┬──────┘│
│         │                │                 │       │
│         └────────────────┼─────────────────┘       │
│                          │                         │
│                   ┌──────▼──────┐                  │
│                   │ Orchestrator│                  │
│                   │   (Router)  │                  │
│                   └──────┬──────┘                  │
│                          │                         │
│      ┌───────────────────┼──────────────────┐      │
│      │                   │                  │      │
│  ┌───▼────┐  ┌──────────▼────────┐  ┌─────▼────┐ │
│  │  RAG   │  │   Wave System     │  │  Cache   │ │
│  │Vectorial│  │ Multi-stage exec │  │  System  │ │
│  └────────┘  └───────────────────┘  └──────────┘ │
│                                                    │
└────────────────────────────────────────────────────┘
```

## 🎯 Comandos Principales

### Desarrollo
- `/nc:implement` - Implementación inteligente de features
- `/nc:build` - Construcción y compilación optimizada
- `/nc:design` - Diseño de arquitectura y sistemas
- `/nc:refactor` - Refactorización inteligente

### Análisis y Calidad
- `/nc:analyze` - Análisis profundo multi-dimensional
- `/nc:security` - Auditoría de seguridad completa
- `/nc:performance` - Optimización de rendimiento
- `/nc:test` - Testing inteligente con coverage

### Productividad
- `/nc:remember` - Búsqueda en memoria vectorial
- `/nc:automate` - Automatización de tareas repetitivas
- `/nc:document` - Documentación automática
- `/nc:deploy` - Despliegue inteligente

### Meta-comandos
- `/nc:help` - Ayuda contextual inteligente
- `/nc:config` - Configuración del framework
- `/nc:stats` - Métricas y estadísticas de uso
- `/nc:upgrade` - Actualización automática

## 🎭 Personas Disponibles

| Persona | Especialidad | Auto-activación |
|---------|-------------|-----------------|
| 🏗️ **architect** | Diseño de sistemas | Arquitectura, escalabilidad |
| 🎨 **frontend** | UI/UX, accesibilidad | Componentes, responsive |
| ⚙️ **backend** | APIs, infraestructura | Endpoints, bases de datos |
| 🔍 **analyzer** | Debugging, investigación | Errores, problemas |
| 🛡️ **security** | Seguridad, vulnerabilidades | Auth, encriptación |
| ⚡ **performance** | Optimización | Lentitud, memoria |
| 📝 **documenter** | Documentación profesional | README, APIs |
| 🧪 **tester** | Testing, QA | Tests, coverage |
| 🔧 **devops** | CI/CD, deployment | Docker, Kubernetes |
| 🧹 **refactorer** | Code quality | Deuda técnica |
| 👨‍🏫 **mentor** | Enseñanza, explicaciones | Tutoriales |
| 🤖 **ai-specialist** | IA, ML, LLMs | Modelos, training |
| 📊 **data-analyst** | Análisis de datos | Métricas, insights |
| 🌐 **fullstack** | End-to-end | Proyectos completos |
| 🚀 **innovator** | Nuevas tecnologías | Experimentación |

## 🔌 Integración MCP

### Context7 - Documentación Oficial
- Acceso a documentación de 1000+ librerías
- Patrones y mejores prácticas
- Ejemplos de código actualizados

### Sequential - Análisis Complejo
- Razonamiento multi-paso
- Resolución de problemas complejos
- Análisis arquitectónico

### Magic - Generación UI
- Componentes modernos
- Design systems
- Accesibilidad integrada

### Playwright - Testing Browser
- E2E testing automatizado
- Cross-browser validation
- Performance metrics

## 🧠 Sistema RAG Vectorial

### Características
- **Búsqueda semántica** en todo tu historial
- **Contexto automático** relevante
- **Aprendizaje continuo** de patrones
- **Sincronización cloud** opcional

### Uso
```bash
# Buscar en memoria
/nc:remember "error de Docker con networking"

# Guardar conocimiento importante
/nc:learn "La solución al problema X es Y"

# Exportar conocimiento
/nc:export --format markdown --output knowledge.md
```

## 📊 Métricas y Observabilidad

El framework incluye métricas automáticas:
- Tokens usados por sesión
- Comandos más utilizados
- Personas más activas
- Tiempos de respuesta
- Tasa de éxito de operaciones

Ver métricas:
```bash
nubemclaude stats
```

## 🚀 Casos de Uso

### 1. Desarrollo Full-Stack
```bash
/nc:implement "sistema de autenticación con OAuth2"
# Activa: backend + security personas
# Usa: Context7 para patterns, Sequential para diseño
# Resultado: Auth completo con tests y docs
```

### 2. Debugging Complejo
```bash
/nc:analyze --deep "memory leak en producción"
# Activa: analyzer + performance personas
# Usa: RAG para casos similares anteriores
# Resultado: Root cause + solución + prevención
```

### 3. Refactoring Masivo
```bash
/nc:refactor --wave "migrar de JavaScript a TypeScript"
# Activa: Wave system con 5 etapas
# Usa: Múltiples personas coordinadas
# Resultado: Migración incremental validada
```

## 🔧 Configuración

### Archivo de configuración: `~/.nubemclaude/config.yaml`

```yaml
# Configuración general
framework:
  version: 1.0.0
  profile: complete
  language: es
  
# Personas
personas:
  auto_activation: true
  default: architect
  confidence_threshold: 0.75

# RAG System
rag:
  enabled: true
  provider: qdrant
  embedding_model: text-embedding-3-small
  max_results: 10

# MCP Servers
mcp:
  context7:
    enabled: true
    cache_ttl: 3600
  sequential:
    enabled: true
    complexity_threshold: 0.7
  magic:
    enabled: true
    frameworks: [react, vue, angular]
  playwright:
    enabled: false
    browsers: [chrome, firefox]

# Performance
performance:
  token_optimization: true
  cache_enabled: true
  parallel_operations: true
  max_concurrent: 3

# Observability
telemetry:
  enabled: true
  anonymous: true
  metrics_endpoint: local
```

## 📚 Documentación

- [Guía de Inicio Rápido](docs/quickstart.md)
- [Manual de Comandos](docs/commands.md)
- [Guía de Personas](docs/personas.md)
- [Configuración RAG](docs/rag-setup.md)
- [Integración MCP](docs/mcp-integration.md)
- [API Reference](docs/api-reference.md)
- [Troubleshooting](docs/troubleshooting.md)

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Ver [CONTRIBUTING.md](CONTRIBUTING.md)

### Cómo contribuir
1. Fork el proyecto
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📈 Roadmap

- [x] v1.0: Framework unificado base
- [ ] v1.1: GUI para configuración
- [ ] v1.2: Marketplace de plugins
- [ ] v1.3: Multi-LLM support (GPT-4, Gemini)
- [ ] v2.0: Framework as a Service (FaaS)

## 📄 Licencia

Distribuido bajo licencia MIT. Ver [LICENSE](LICENSE) para más información.

## 🙏 Agradecimientos

Este framework combina el trabajo de múltiples proyectos brillantes:
- SuperClaude Team - Por el sistema modular
- NubemClaudeCode - Por el sistema RAG
- awesome-claude-code - Por los subagentes
- Anthropic - Por Claude y Claude Code
- La comunidad open source

## 💬 Soporte

- 📧 Email: david.anguera@nubemsystems.com
- 💬 Discord: [NubemClaude Community](https://discord.gg/nubemclaude)
- 🐛 Issues: [GitHub Issues](https://github.com/NUbem000/NubemClaude-Framework/issues)
- 📖 Wiki: [GitHub Wiki](https://github.com/NUbem000/NubemClaude-Framework/wiki)

---

<p align="center">
  Hecho con ❤️ por NubemSystems<br>
  Unificando lo mejor de la comunidad Claude
</p>