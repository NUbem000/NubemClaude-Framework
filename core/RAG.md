# RAG.md - NubemClaude Framework RAG System

Sistema de Retrieval-Augmented Generation con memoria vectorial persistente.

## Arquitectura RAG

```
User Query → Embedding → Vector Search → Context Retrieval
                ↓                           ↓
         Semantic Understanding      Relevant Context
                ↓                           ↓
            Smart Filtering          Context Injection
                ↓                           ↓
           Ranked Results      Enhanced Claude Response
```

## Componentes Core

### 1. Vector Database (Qdrant)
```yaml
qdrant:
  deployment: Cloud Run
  memory: 2GB
  cpu: 2
  collections:
    - conversations: All chat history
    - solutions: Successful solutions
    - patterns: Code patterns
    - decisions: Architectural decisions
    - errors: Errors and fixes
```

### 2. Embedding System
```yaml
embeddings:
  provider: OpenAI / Vertex AI
  model: text-embedding-3-small
  dimensions: 1536
  batch_size: 100
  cache: true
```

### 3. PostgreSQL + pgvector
```yaml
postgresql:
  version: 15
  extension: pgvector
  purpose: Hybrid search (keyword + semantic)
  indexes:
    - semantic: HNSW index
    - keyword: GIN index
    - temporal: BTREE on timestamp
```

## Tipos de Memoria

### Conversation Memory
- **Qué**: Todas las conversaciones con Claude
- **Cómo**: Embeddings por mensaje + contexto
- **Uso**: Continuidad entre sesiones
- **TTL**: Indefinido (con compresión)

### Solution Memory
- **Qué**: Soluciones que funcionaron
- **Cómo**: Problem → Solution pairs
- **Uso**: Reutilizar soluciones exitosas
- **Score**: Success rate + user feedback

### Pattern Memory
- **Qué**: Patterns de código y arquitectura
- **Cómo**: Code snippets + contexto de uso
- **Uso**: Aplicar patterns probados
- **Tags**: Language, framework, domain

### Decision Memory
- **Qué**: ADRs y decisiones importantes
- **Cómo**: Decision + rationale + outcome
- **Uso**: Mantener consistencia
- **Links**: Related decisions

### Error Memory
- **Qué**: Errores encontrados y sus fixes
- **Cómo**: Error → Root cause → Solution
- **Uso**: Debugging más rápido
- **Prevention**: Evitar errores similares

## Flujo de Procesamiento

### 1. Ingesta
```python
def ingest_to_rag(content, metadata):
    # 1. Limpiar y preparar texto
    clean_text = preprocess(content)
    
    # 2. Generar embedding
    embedding = generate_embedding(clean_text)
    
    # 3. Extraer entidades y conceptos
    entities = extract_entities(clean_text)
    concepts = identify_concepts(clean_text)
    
    # 4. Calcular importancia
    importance = calculate_importance(
        content_length=len(clean_text),
        entity_count=len(entities),
        user_interaction=metadata.get('interaction_type'),
        success_signal=metadata.get('success')
    )
    
    # 5. Almacenar en vector DB
    store_vector(
        embedding=embedding,
        text=clean_text,
        metadata={
            **metadata,
            'entities': entities,
            'concepts': concepts,
            'importance': importance,
            'timestamp': now()
        }
    )
```

### 2. Búsqueda
```python
def search_rag(query, filters=None):
    # 1. Generar embedding de query
    query_embedding = generate_embedding(query)
    
    # 2. Búsqueda vectorial
    vector_results = vector_search(
        embedding=query_embedding,
        limit=20,
        filters=filters
    )
    
    # 3. Búsqueda híbrida (si enabled)
    if hybrid_search_enabled:
        keyword_results = keyword_search(query, limit=10)
        vector_results = merge_results(vector_results, keyword_results)
    
    # 4. Re-ranking con contexto
    ranked_results = rerank_with_context(
        results=vector_results,
        user_context=get_user_context(),
        temporal_weight=0.2,  # Recent = more relevant
        success_weight=0.3    # Successful = more relevant
    )
    
    # 5. Filtrado final
    final_results = filter_and_dedupe(
        results=ranked_results,
        max_tokens=8000,
        diversity_threshold=0.7
    )
    
    return final_results
```

### 3. Context Injection
```python
def inject_context(user_query, rag_results):
    # 1. Formatear contexto
    context = format_rag_context(rag_results)
    
    # 2. Crear prompt aumentado
    augmented_prompt = f"""
    Contexto relevante de conversaciones anteriores:
    {context}
    
    Pregunta actual del usuario:
    {user_query}
    
    Instrucciones:
    - Usa el contexto para informar tu respuesta
    - Mantén consistencia con decisiones previas
    - Si hay soluciones anteriores similares, adáptalas
    - Si hay errores previos relacionados, evítalos
    """
    
    return augmented_prompt
```

## Estrategias de Búsqueda

### Semantic Search
```yaml
strategy: cosine_similarity
threshold: 0.7
boost_factors:
  - recency: 1.2
  - success: 1.5
  - user_marked: 2.0
```

### Hybrid Search
```yaml
combination: RRF (Reciprocal Rank Fusion)
weights:
  vector: 0.7
  keyword: 0.3
min_keyword_matches: 2
```

### Contextual Search
```yaml
context_awareness:
  - current_project
  - active_persona
  - recent_commands
  - time_of_day
  - error_state
```

## Optimizaciones

### Caching Strategy
```yaml
cache_layers:
  L1_memory: 
    size: 100 embeddings
    ttl: session
  L2_redis:
    size: 1000 embeddings
    ttl: 24h
  L3_persistent:
    size: unlimited
    ttl: indefinite
```

### Compression
```yaml
compression:
  old_conversations:
    strategy: summarization
    trigger: age > 30 days
    compression_ratio: 10:1
  
  similar_solutions:
    strategy: deduplication
    similarity_threshold: 0.95
    keep: highest_rated
```

### Performance
```yaml
performance:
  embedding_batch: 100 items
  search_parallel: 3 queries
  index_type: HNSW
  ef_construction: 200
  m: 16
```

## Privacidad y Seguridad

### Data Sanitization
```python
def sanitize_for_rag(content):
    # Remover información sensible
    content = remove_secrets(content)  # API keys, passwords
    content = remove_pii(content)      # Emails, phones, IDs
    content = remove_internal(content) # Internal URLs, IPs
    
    # Anonimizar si necesario
    if requires_anonymization:
        content = anonymize_entities(content)
    
    return content
```

### Access Control
```yaml
access_control:
  user_isolation: true
  project_isolation: true
  shared_knowledge:
    requires: explicit_permission
    granularity: per_collection
```

## Comandos RAG

### Búsqueda y Recuperación
```bash
# Buscar en memoria
/nc:remember "error de Docker"

# Búsqueda con filtros
/nc:remember "API REST" --filter project:current --limit 5

# Búsqueda por similitud
/nc:similar "este código"
```

### Gestión de Memoria
```bash
# Guardar conocimiento importante
/nc:learn "La solución al problema X es Y" --priority high

# Marcar como exitoso
/nc:mark-success "session-123"

# Olvidar información
/nc:forget "pattern-outdated" --confirm
```

### Análisis y Estadísticas
```bash
# Ver estadísticas RAG
/nc:rag-stats

# Analizar memoria
/nc:analyze-memory --domain backend

# Exportar conocimiento
/nc:export-knowledge --format json --filter domain:security
```

## Integración con Personas

Cada persona usa RAG de forma diferente:

```yaml
architect:
  prioritize: [decisions, patterns, architecture]
  boost: architectural_decisions * 2.0

security:
  prioritize: [vulnerabilities, fixes, compliance]
  filter: exclude_outdated_vulnerabilities

frontend:
  prioritize: [components, styles, accessibility]
  boost: recent_ui_patterns * 1.5

analyzer:
  prioritize: [errors, debugging, root_causes]
  include: all_similar_errors
```

## Métricas RAG

### Performance Metrics
- Search latency: <200ms
- Embedding generation: <100ms
- Result relevance: >0.8
- Cache hit rate: >60%

### Quality Metrics
- Precision: % relevant results
- Recall: % found relevant items
- User satisfaction: feedback score
- Context usefulness: impact on response

### Usage Metrics
- Queries per session
- Knowledge items stored
- Memory growth rate
- Most accessed patterns

## Configuración

```yaml
rag:
  enabled: true
  provider: qdrant
  
  embedding:
    model: text-embedding-3-small
    cache: true
    batch_size: 100
  
  search:
    default_limit: 10
    max_limit: 50
    min_similarity: 0.7
    hybrid: true
  
  memory:
    max_size: 10GB
    compression: true
    ttl_days: 365
  
  privacy:
    sanitize: true
    user_isolation: true
    encryption: AES-256
```

## Beneficios Clave

1. **Continuidad**: Mantiene contexto entre sesiones
2. **Aprendizaje**: Mejora con cada interacción
3. **Eficiencia**: Reutiliza soluciones exitosas
4. **Personalización**: Se adapta a cada usuario
5. **Colaboración**: Comparte conocimiento (con permiso)

---

*RAG: Transformando cada interacción en conocimiento persistente*