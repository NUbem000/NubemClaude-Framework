# COMMANDS.md - NubemClaude Framework Command System

Sistema unificado de comandos que combina lo mejor de todos los frameworks.

## Arquitectura de Comandos

### Estructura Core
```yaml
command_structure:
  prefix: "/nc:"  # NubemClaude prefix
  format: "/nc:[verb] [target] [flags]"
  categories: [development, analysis, quality, productivity, meta]
  wave_enabled: true
  rag_integration: true
  persona_aware: true
```

## Comandos de Desarrollo

### `/nc:implement [feature] [flags]`
**Propósito**: Implementación inteligente de features con RAG y personas
- **Auto-Persona**: Frontend, Backend, Fullstack según contexto
- **RAG Integration**: Busca implementaciones similares anteriores
- **MCP**: Magic (UI), Context7 (patterns), Sequential (logic)
- **Flags**: `--style [tdd|bdd|ddd]`, `--framework [auto|react|vue|node]`

### `/nc:build [target] [flags]`
**Propósito**: Construcción y compilación optimizada
- **Auto-Persona**: DevOps, Backend
- **RAG**: Reutiliza configuraciones de build exitosas
- **Wave**: Para builds multi-etapa complejos
- **Flags**: `--env [dev|staging|prod]`, `--optimize`, `--parallel`

### `/nc:design [system] [flags]`
**Propósito**: Diseño arquitectónico con memoria histórica
- **Auto-Persona**: Architect, Frontend (para UI)
- **RAG**: Recupera decisiones arquitectónicas previas
- **MCP**: Sequential (análisis), Context7 (patterns)
- **Outputs**: Diagramas C4, ADRs, especificaciones

## Comandos de Análisis

### `/nc:analyze [target] [flags]`
**Propósito**: Análisis multi-dimensional con contexto histórico
- **Auto-Persona**: Analyzer, Security, Performance según focus
- **RAG**: Compara con análisis previos similares
- **Wave**: Para análisis system-wide
- **Flags**: `--deep`, `--focus [security|performance|quality]`, `--compare`

### `/nc:troubleshoot [issue] [flags]`
**Propósito**: Debugging inteligente con memoria de soluciones
- **Auto-Persona**: Analyzer, specialist según dominio
- **RAG**: Busca issues similares resueltos anteriormente
- **MCP**: Sequential (root cause), Playwright (reproducción)
- **Flags**: `--reproduce`, `--suggest-fix`, `--prevent`

### `/nc:explain [concept] [flags]`
**Propósito**: Explicaciones educativas personalizadas
- **Auto-Persona**: Mentor, Documenter
- **RAG**: Adapta explicación a nivel de conocimiento del usuario
- **Flags**: `--level [beginner|intermediate|expert]`, `--examples`

## Comandos de Análisis Predictivo

### `/nc:predict [target] [flags]`
**Propósito**: Predicción de issues antes de que ocurran
- **Auto-Persona**: Analyzer, Security, Performance
- **ML Engine**: Modelo predictivo entrenado
- **Outputs**: Issues potenciales, probabilidad, prevención
- **Flags**: `--confidence [0-1]`, `--category [bugs|security|performance]`

### `/nc:forecast [metric] [flags]`
**Propósito**: Proyección de métricas futuras
- **Auto-Persona**: Performance, Data-analyst
- **RAG**: Histórico de métricas similares
- **Outputs**: Proyecciones, tendencias, alertas
- **Flags**: `--period [days]`, `--model [linear|ml]`

### `/nc:estimate-complexity [target]`
**Propósito**: Estimación precisa de complejidad
- **Auto-Persona**: Architect, Analyzer
- **Analysis**: Ciclomática, cognitiva, dependencies
- **Outputs**: Score, breakdown, recommendations
- **Flags**: `--include-debt`, `--future-proof`

## Comandos de Calidad

### `/nc:improve [target] [flags]`
**Propósito**: Mejora iterativa con validación
- **Auto-Persona**: Refactorer, Performance, Quality
- **RAG**: Aplica patrones de mejora exitosos
- **Wave**: Mejora progresiva multi-etapa
- **Flags**: `--iterate [n]`, `--validate`, `--metrics`

### `/nc:security [target] [flags]`
**Propósito**: Auditoría y hardening de seguridad
- **Auto-Persona**: Security specialist
- **RAG**: Usa base de vulnerabilidades conocidas
- **MCP**: Sequential (threat modeling)
- **Flags**: `--audit`, `--fix`, `--compliance [OWASP|PCI|GDPR]`

### `/nc:security-scan [target] [flags]`
**Propósito**: Escaneo profundo con Security Engine
- **Auto-Persona**: Security
- **Engine**: SAST + dependency check + secrets scan
- **Auto-fix**: Corrige issues automáticamente
- **Flags**: `--deep`, `--fix`, `--block-critical`

### `/nc:review [target] [flags]`
**Propósito**: Code review multi-agente (de CCPlugins)
- **Auto-Persona**: Multiple (Security, Performance, Quality)
- **Approach**: Múltiples perspectivas simultáneas
- **Outputs**: Issues, suggestions, approval score
- **Flags**: `--strict`, `--focus [area]`, `--pr`

### `/nc:test [type] [flags]`
**Propósito**: Testing inteligente con coverage óptimo
- **Auto-Persona**: Tester, QA
- **RAG**: Reutiliza casos de test exitosos
- **MCP**: Playwright (E2E), Sequential (test strategy)
- **Flags**: `--type [unit|integration|e2e]`, `--coverage`, `--generate`

### `/nc:refactor [target] [flags]`
**Propósito**: Refactorización sistemática
- **Auto-Persona**: Refactorer
- **RAG**: Aplica refactors exitosos similares
- **Wave**: Para refactoring masivo
- **Flags**: `--pattern [name]`, `--safe`, `--incremental`

## Comandos de Productividad

### `/nc:remember [query]`
**Propósito**: Búsqueda semántica en memoria vectorial
- **RAG**: Búsqueda principal en base vectorial
- **Outputs**: Contextos relevantes, soluciones anteriores
- **Flags**: `--limit [n]`, `--date-range`, `--similarity [0-1]`

### `/nc:learn [knowledge]`
**Propósito**: Guardar conocimiento importante en RAG
- **RAG**: Indexa y embeddings para futuro uso
- **Categorización**: Automática por dominio
- **Flags**: `--category`, `--tags`, `--priority`

### `/nc:automate [task] [flags]`
**Propósito**: Automatización inteligente de tareas
- **Auto-Persona**: DevOps, Automation specialist
- **RAG**: Reutiliza automatizaciones previas
- **Outputs**: Scripts, workflows, CI/CD configs
- **Flags**: `--schedule`, `--trigger`, `--notify`

### `/nc:document [target] [flags]`
**Propósito**: Documentación profesional multi-idioma
- **Auto-Persona**: Documenter, Scribe
- **RAG**: Mantiene consistencia con docs previos
- **MCP**: Context7 (standards)
- **Flags**: `--format [md|rst|html]`, `--lang [es|en]`, `--audience`

### `/nc:deploy [target] [flags]`
**Propósito**: Despliegue inteligente con rollback
- **Auto-Persona**: DevOps
- **RAG**: Usa configuraciones de deploy exitosas
- **Wave**: Deploy multi-etapa con validación
- **Flags**: `--env`, `--strategy [blue-green|canary|rolling]`, `--dry-run`

## Comandos Multi-Agente

### `/nc:orchestrate [workflow] [flags]`
**Propósito**: Orquestación de múltiples agentes
- **Coordination**: Local + cloud agents
- **Load balancing**: Distribución inteligente
- **Outputs**: Resultados agregados y consensuados
- **Flags**: `--agents [list]`, `--strategy [parallel|sequential]`

### `/nc:swarm [operation] [flags]`
**Propósito**: Operación distribuida masiva
- **Scale**: 10+ agentes simultáneos
- **Use cases**: Refactoring masivo, auditorías
- **Coordination**: Swarm intelligence
- **Flags**: `--size [n]`, `--consensus`, `--timeout`

## Comandos de Integración

### `/nc:github [action] [flags]`
**Propósito**: Integración con GitHub via MCP
- **MCP Server**: GitHub official
- **Actions**: PR, issues, workflows, releases
- **Automation**: CI/CD triggers
- **Flags**: `--repo`, `--branch`, `--auto-merge`

### `/nc:docker [command] [flags]`
**Propósito**: Gestión de containers
- **MCP Server**: Docker
- **Commands**: build, run, compose, optimize
- **Features**: Multi-stage, cache optimization
- **Flags**: `--optimize`, `--security-scan`, `--push`

### `/nc:cloud [provider] [action]`
**Propósito**: Operaciones cloud multi-provider
- **Providers**: AWS, GCP, Azure
- **Actions**: deploy, scale, monitor, cost-optimize
- **IaC**: Terraform generation
- **Flags**: `--environment`, `--dry-run`, `--cost-estimate`

## Meta-Comandos

### `/nc:help [command]`
**Propósito**: Ayuda contextual inteligente
- **RAG**: Ejemplos de uso real del usuario
- **Outputs**: Ayuda personalizada con ejemplos
- **Flags**: `--examples`, `--interactive`

### `/nc:config [setting] [value]`
**Propósito**: Configuración del framework
- **Scopes**: global, project, session
- **Validation**: Verifica configuraciones válidas
- **Flags**: `--show`, `--reset`, `--export`

### `/nc:stats [period]`
**Propósito**: Métricas y estadísticas de uso
- **Metrics**: Tokens, comandos, personas, tiempo
- **Visualización**: Gráficos en terminal
- **Flags**: `--detailed`, `--export`, `--compare`

### `/nc:upgrade [component]`
**Propósito**: Actualización inteligente del framework
- **Safety**: Backup automático antes de actualizar
- **Validation**: Verifica compatibilidad
- **Flags**: `--check`, `--force`, `--rollback`

### `/nc:context [action]`
**Propósito**: Gestión del contexto RAG
- **Actions**: load, save, clear, export, import
- **RAG**: Control directo sobre memoria vectorial
- **Flags**: `--session`, `--persistent`, `--merge`

## Comandos Especiales

### `/nc:wave [operation] [flags]`
**Propósito**: Orquestación multi-etapa compleja
- **Wave System**: Ejecución coordinada de múltiples etapas
- **Auto-Scaling**: Ajusta recursos según complejidad
- **Flags**: `--stages [n]`, `--parallel`, `--checkpoint`

### `/nc:delegate [task] [flags]`
**Propósito**: Delegación a sub-agentes especializados
- **Multi-Agent**: Coordina múltiples agentes
- **Load Balancing**: Distribuye trabajo óptimamente
- **Flags**: `--agents [list]`, `--strategy`, `--aggregate`

### `/nc:chat [mode]`
**Propósito**: Modo conversacional interactivo
- **Modes**: normal, expert, tutorial, pair-programming
- **RAG**: Contexto continuo durante chat
- **Flags**: `--persona`, `--style`, `--save-session`

## Composición de Comandos

Los comandos se pueden componer para operaciones complejas:

```bash
# Análisis + Mejora + Test
/nc:analyze --deep | /nc:improve --iterate 3 | /nc:test --coverage

# Remember + Implement
/nc:remember "auth system" | /nc:implement "OAuth2 authentication"

# Design + Document
/nc:design "microservices" | /nc:document --format md --lang es
```

## Auto-Activación de Features

### RAG Automático
- Todos los comandos buscan contexto relevante antes de ejecutar
- Aprenden de cada ejecución para mejorar futuras

### Personas Automáticas
- Se activan basado en comando + contexto + histórico
- Pueden colaborar múltiples personas en un comando

### Wave Automático
- Se activa cuando complejidad > 0.7
- O cuando hay múltiples dominios/etapas

### MCP Automático
- Context7: Para documentación y patterns
- Sequential: Para análisis complejo
- Magic: Para generación UI
- Playwright: Para testing y automation

## Flags Globales

Aplicables a todos los comandos:

- `--verbose`: Output detallado
- `--quiet`: Mínimo output
- `--json`: Output en JSON
- `--no-rag`: Desactiva búsqueda RAG
- `--no-persona`: Desactiva auto-personas
- `--no-mcp`: Desactiva servers MCP
- `--dry-run`: Simula sin ejecutar
- `--explain`: Explica qué haría
- `--token-limit [n]`: Límite de tokens
- `--profile [name]`: Usa perfil específico

---

*Comandos diseñados para ser intuitivos, potentes y componibles*