# ORCHESTRATOR.md - NubemClaude Intelligent Routing System

Sistema de routing inteligente que combina RAG, personas y MCP para decisiones óptimas.

## Arquitectura de Decisión

```yaml
decision_flow:
  1_input_analysis: Parse user request
  2_rag_search: Search relevant context
  3_complexity_assessment: Evaluate task complexity
  4_persona_selection: Choose appropriate experts
  5_mcp_activation: Enable needed servers
  6_execution_strategy: Plan execution path
  7_quality_gates: Define validation points
  8_execute: Run with monitoring
```

## Motor de Detección

### Pattern Recognition con RAG
```python
def analyze_request(user_input):
    # 1. RAG Search for similar requests
    similar_requests = rag_search(user_input, limit=5)
    
    # 2. Extract patterns from history
    patterns = extract_patterns(similar_requests)
    
    # 3. Identify domain and complexity
    domain = identify_domain(user_input, patterns)
    complexity = calculate_complexity(user_input, patterns)
    
    # 4. Get user preferences from RAG
    user_preferences = get_user_preferences()
    
    return {
        'domain': domain,
        'complexity': complexity,
        'patterns': patterns,
        'preferences': user_preferences,
        'similar_cases': similar_requests
    }
```

### Complexity Scoring
```yaml
factors:
  scope: 0.25        # file, module, project, system
  domains: 0.20      # single vs multiple
  operations: 0.20   # create, modify, analyze
  dependencies: 0.15 # standalone vs integrated
  risk: 0.10        # low, medium, high, critical
  tokens: 0.10      # estimated token usage
```

## Routing Intelligence

### Decision Matrix
| Pattern | Complexity | RAG Support | Routing Decision |
|---------|------------|-------------|------------------|
| "implement feature" | Low | Similar found | Use RAG pattern + appropriate persona |
| "debug error" | Medium | Error found | analyzer + RAG solution |
| "architecture design" | High | ADRs found | architect + Sequential + RAG context |
| "security audit" | High | Previous audits | security + Wave system + RAG findings |

### Persona Selection Algorithm
```python
def select_personas(analysis):
    # Base selection from domain
    primary_persona = DOMAIN_TO_PERSONA[analysis['domain']]
    
    # Check RAG for successful persona combinations
    successful_combos = rag_get_successful_personas(
        task_type=analysis['domain'],
        complexity=analysis['complexity']
    )
    
    # Calculate confidence scores
    personas = []
    for persona in ALL_PERSONAS:
        confidence = calculate_confidence(
            persona=persona,
            analysis=analysis,
            history=successful_combos
        )
        if confidence > 0.7:
            personas.append((persona, confidence))
    
    # Sort by confidence and return top 3
    return sorted(personas, key=lambda x: x[1], reverse=True)[:3]
```

### MCP Server Selection
```python
def select_mcp_servers(analysis, personas):
    servers = set()
    
    # Persona preferences
    for persona, _ in personas:
        servers.update(PERSONA_MCP_PREFERENCES[persona])
    
    # Task requirements
    if 'documentation' in analysis['patterns']:
        servers.add('context7')
    if analysis['complexity'] > 0.7:
        servers.add('sequential')
    if 'ui' in analysis['domain']:
        servers.add('magic')
    if 'testing' in analysis['patterns']:
        servers.add('playwright')
    
    # RAG recommendations
    rag_servers = rag_get_successful_servers(analysis['similar_cases'])
    servers.update(rag_servers)
    
    return list(servers)
```

## Wave Orchestration

### Wave Detection
```yaml
wave_triggers:
  automatic:
    - complexity >= 0.8
    - domains >= 3
    - estimated_time > 30min
    - files > 50
  
  patterns:
    - "comprehensive"
    - "systematic"
    - "refactor entire"
    - "migrate"
    - "audit"
```

### Wave Strategy Selection
```python
def select_wave_strategy(analysis):
    if 'security' in analysis['domain']:
        return 'validation'  # Extra validation at each stage
    elif 'performance' in analysis['patterns']:
        return 'progressive'  # Incremental improvements
    elif analysis['complexity'] > 0.9:
        return 'systematic'  # Methodical approach
    elif 'experimental' in analysis['patterns']:
        return 'adaptive'  # Adjust on the fly
    else:
        return 'standard'
```

## Quality Gates

### Validation Pipeline
```yaml
gates:
  pre_execution:
    - syntax_validation
    - dependency_check
    - resource_availability
    - risk_assessment
  
  during_execution:
    - progress_monitoring
    - error_detection
    - resource_usage
    - timeout_prevention
  
  post_execution:
    - output_validation
    - test_execution
    - performance_check
    - security_scan
  
  rag_feedback:
    - success_signal
    - pattern_extraction
    - learning_update
```

## Resource Management

### Token Optimization
```python
def optimize_tokens(context, limit=8000):
    # 1. Get most relevant from RAG
    rag_context = rag_get_relevant(context, max_tokens=limit*0.4)
    
    # 2. Compress if needed
    if estimate_tokens(context) > limit:
        context = compress_context(context)
    
    # 3. Prioritize recent and successful
    context = prioritize_context(
        context=context,
        weights={
            'recency': 0.3,
            'success': 0.4,
            'relevance': 0.3
        }
    )
    
    return context
```

### Parallel Processing
```yaml
parallelization:
  independent_tasks:
    strategy: concurrent
    max_workers: 3
  
  dependent_tasks:
    strategy: pipeline
    buffer_size: 5
  
  rag_operations:
    strategy: async
    batch_size: 10
```

## Learning Loop

### Success Tracking
```python
def track_execution(execution_id, result):
    # Record in RAG
    rag_store({
        'id': execution_id,
        'request': original_request,
        'analysis': initial_analysis,
        'personas': selected_personas,
        'mcp_servers': used_servers,
        'strategy': execution_strategy,
        'result': result,
        'metrics': {
            'tokens': tokens_used,
            'time': execution_time,
            'success': success_score
        }
    })
    
    # Update patterns if successful
    if result['success'] > 0.8:
        update_successful_patterns(execution_id)
```

### Pattern Evolution
```yaml
learning:
  success_threshold: 0.8
  failure_analysis: true
  pattern_update_frequency: daily
  
  metrics_tracked:
    - persona_effectiveness
    - mcp_server_usage
    - strategy_success_rate
    - token_efficiency
    - user_satisfaction
```

## Emergency Protocols

### Fallback Strategies
```yaml
fallbacks:
  rag_unavailable:
    action: Use cached patterns
    degradation: 20%
  
  persona_conflict:
    action: Use primary persona only
    confidence: -15%
  
  mcp_timeout:
    action: Use native tools
    retry: exponential_backoff
  
  token_limit:
    action: Progressive compression
    preserve: critical_context
```

### Resource Limits
```yaml
limits:
  max_tokens_per_request: 32000
  max_rag_searches: 10
  max_personas_active: 3
  max_mcp_servers: 4
  max_parallel_tasks: 5
  timeout_seconds: 300
```

## Configuration

```yaml
orchestrator:
  # Detection
  pattern_recognition:
    enabled: true
    min_confidence: 0.7
  
  # RAG Integration  
  rag_context:
    always_search: true
    max_results: 10
    boost_recent: 1.2
  
  # Routing
  routing:
    use_history: true
    learn_from_outcomes: true
    confidence_threshold: 0.7
  
  # Quality
  quality_gates:
    enforce: true
    skip_on_emergency: false
  
  # Learning
  learning:
    enabled: true
    update_frequency: after_each_execution
```

---

*Orchestrator: Dirigiendo cada decisión con inteligencia y memoria*