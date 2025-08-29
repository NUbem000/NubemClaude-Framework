# SECURITY.md - NubemClaude Security Rules Engine

Motor de seguridad automático con reglas proactivas, compliance y predicción de vulnerabilidades.

## 🛡️ Security Architecture

```yaml
security_engine:
  version: "2.0"
  mode: proactive  # proactive | reactive | audit
  compliance: [OWASP, PCI-DSS, GDPR, SOC2, ISO27001]
  auto_fix: true
  block_on_critical: true
```

## Core Security Rules

### 1. Input Validation Rules
```yaml
input_validation:
  sql_injection:
    severity: CRITICAL
    patterns:
      - "SELECT.*FROM.*WHERE"
      - "DROP TABLE"
      - "'; DELETE"
      - "1=1"
      - "OR '1'='1"
    prevention:
      - Use parameterized queries
      - Validate all inputs
      - Escape special characters
    auto_fix: true
    
  xss_prevention:
    severity: HIGH
    patterns:
      - "<script"
      - "javascript:"
      - "onclick="
      - "onerror="
    prevention:
      - HTML encode output
      - Use Content Security Policy
      - Validate input types
    auto_fix: true
    
  command_injection:
    severity: CRITICAL
    patterns:
      - "exec("
      - "system("
      - "eval("
      - "`${user_input}`"
    prevention:
      - Never use eval with user input
      - Sanitize shell commands
      - Use safe APIs
    auto_fix: true
```

### 2. Authentication & Authorization
```yaml
authentication:
  weak_passwords:
    severity: HIGH
    rules:
      - min_length: 12
      - require_uppercase: true
      - require_lowercase: true
      - require_numbers: true
      - require_special: true
      - no_common_passwords: true
      - no_username_in_password: true
    
  session_management:
    severity: HIGH
    rules:
      - secure_cookies: true
      - httponly_cookies: true
      - samesite_strict: true
      - session_timeout: 30min
      - regenerate_on_privilege_change: true
    
  multi_factor:
    severity: MEDIUM
    enforce_for:
      - admin_users
      - sensitive_operations
      - password_reset
      
authorization:
  least_privilege:
    severity: HIGH
    enforce: true
    validate_on_every_request: true
    
  rbac:
    severity: MEDIUM
    roles_must_be_defined: true
    no_hardcoded_roles: true
```

### 3. Data Protection
```yaml
data_protection:
  encryption_at_rest:
    severity: HIGH
    algorithms:
      - AES-256-GCM
      - ChaCha20-Poly1305
    key_management: KMS
    
  encryption_in_transit:
    severity: CRITICAL
    min_tls_version: "1.3"
    cipher_suites:
      - TLS_AES_256_GCM_SHA384
      - TLS_CHACHA20_POLY1305_SHA256
    enforce_https: true
    hsts: true
    
  sensitive_data:
    severity: CRITICAL
    patterns:
      - credit_card: \d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}
      - ssn: \d{3}-\d{2}-\d{4}
      - email: [\w._%+-]+@[\w.-]+\.[A-Z]{2,}
      - api_key: (api|key|token|secret)[\w\s]*[:=][\s]*[\w-]+
    handling:
      - never_log: true
      - mask_in_output: true
      - encrypt_in_db: true
```

### 4. API Security
```yaml
api_security:
  rate_limiting:
    severity: MEDIUM
    limits:
      - public: 100/hour
      - authenticated: 1000/hour
      - admin: unlimited
    
  api_keys:
    severity: HIGH
    rules:
      - rotate_every: 90days
      - min_entropy: 128bits
      - never_in_url: true
      - never_in_git: true
      
  cors:
    severity: MEDIUM
    allowed_origins: []  # Whitelist only
    allowed_methods: [GET, POST, PUT, DELETE]
    allowed_headers: [Content-Type, Authorization]
    expose_headers: []
    max_age: 86400
```

## Predictive Security

### Vulnerability Prediction Engine
```python
class VulnerabilityPredictor:
    def __init__(self):
        self.patterns = self.load_vulnerability_patterns()
        self.ml_model = self.load_prediction_model()
        
    async def predict_vulnerabilities(self, code: str) -> list[Prediction]:
        """Predict potential vulnerabilities before they happen"""
        predictions = []
        
        # Pattern-based prediction
        for pattern in self.patterns:
            if pattern.matches(code):
                predictions.append(Prediction(
                    type=pattern.vulnerability_type,
                    confidence=pattern.confidence,
                    location=pattern.match_location,
                    fix=pattern.suggested_fix
                ))
        
        # ML-based prediction
        ml_predictions = await self.ml_model.predict(code)
        predictions.extend(ml_predictions)
        
        return sorted(predictions, key=lambda x: x.confidence, reverse=True)
```

### Security Patterns Database
```yaml
vulnerability_patterns:
  - name: "Hardcoded Credentials"
    pattern: "(password|secret|key)\\s*=\\s*[\"'][^\"']+[\"']"
    confidence: 0.95
    fix: "Use environment variables or secret management"
    
  - name: "Unsafe Deserialization"
    pattern: "pickle\\.loads|yaml\\.load(?!_safe)|eval\\(|exec\\("
    confidence: 0.90
    fix: "Use safe deserialization methods"
    
  - name: "Path Traversal"
    pattern: "\\.\\./|\\.\\.\\\\"
    confidence: 0.85
    fix: "Validate and sanitize file paths"
    
  - name: "Race Condition"
    pattern: "check.*then.*use|TOCTOU"
    confidence: 0.70
    fix: "Use atomic operations"
```

## Compliance Automation

### OWASP Top 10 Checks
```python
class OWASPCompliance:
    async def check_a01_broken_access_control(self, code):
        """A01:2021 – Broken Access Control"""
        issues = []
        # Check for missing authorization
        # Check for IDOR vulnerabilities
        # Check for CORS misconfigurations
        return issues
        
    async def check_a02_cryptographic_failures(self, code):
        """A02:2021 – Cryptographic Failures"""
        issues = []
        # Check for weak algorithms
        # Check for hardcoded keys
        # Check for missing encryption
        return issues
        
    # ... implement all OWASP Top 10
```

### GDPR Compliance
```yaml
gdpr_compliance:
  data_minimization:
    collect_only_necessary: true
    delete_when_not_needed: true
    
  consent:
    explicit_consent_required: true
    granular_consent: true
    withdrawable: true
    
  data_subject_rights:
    right_to_access: implemented
    right_to_rectification: implemented
    right_to_erasure: implemented
    right_to_portability: implemented
    
  breach_notification:
    internal_notification: 24hours
    authority_notification: 72hours
    data_subject_notification: without_undue_delay
```

## Security Commands

### Analysis Commands
```bash
/nc:security-scan [target]     # Deep security scan
/nc:predict-vulnerabilities    # Predict future vulnerabilities
/nc:compliance-check [standard] # Check compliance (OWASP, GDPR, etc)
/nc:threat-model               # Generate threat model
```

### Fix Commands
```bash
/nc:security-fix [issue]       # Auto-fix security issue
/nc:harden [component]         # Apply security hardening
/nc:rotate-secrets             # Rotate all secrets
/nc:patch-dependencies         # Update vulnerable dependencies
```

### Monitoring Commands
```bash
/nc:security-monitor           # Real-time security monitoring
/nc:audit-log                  # View security audit log
/nc:incident-response [alert]  # Handle security incident
```

## Real-time Protection

### Code Analysis Hook
```python
@hook("before_code_generation")
async def security_check(code: str) -> str:
    """Check and fix security issues before code generation"""
    
    # Scan for vulnerabilities
    vulnerabilities = await security_engine.scan(code)
    
    if vulnerabilities.has_critical():
        if auto_fix_enabled:
            code = await security_engine.auto_fix(code, vulnerabilities)
        else:
            raise SecurityException("Critical vulnerabilities found")
    
    # Apply security patterns
    code = await apply_security_patterns(code)
    
    # Add security headers/configs
    code = await add_security_defaults(code)
    
    return code
```

### Runtime Protection
```python
class RuntimeProtection:
    async def protect(self, operation: str, context: dict):
        """Runtime security protection"""
        
        # Check rate limits
        if not await self.check_rate_limit(context.user):
            raise RateLimitException()
            
        # Validate inputs
        await self.validate_inputs(operation, context.inputs)
        
        # Check permissions
        if not await self.check_permissions(context.user, operation):
            raise UnauthorizedException()
            
        # Monitor for anomalies
        if await self.detect_anomaly(operation, context):
            await self.trigger_incident_response()
```

## Security Metrics

### Dashboard Metrics
```yaml
security_metrics:
  vulnerability_score: 
    current: 92/100
    trend: improving
    
  vulnerabilities:
    critical: 0
    high: 2
    medium: 5
    low: 12
    
  compliance:
    owasp: 95%
    gdpr: 100%
    pci_dss: 88%
    
  incidents:
    last_24h: 0
    last_week: 1
    last_month: 3
    
  patches:
    up_to_date: 98%
    pending: 2
    critical_pending: 0
```

## Integration with Personas

### Security Persona Enhancement
```yaml
security_persona:
  auto_activation:
    - Any authentication/authorization code
    - API endpoints
    - Database queries
    - File operations
    - Network requests
    
  capabilities:
    - Threat modeling
    - Vulnerability assessment
    - Penetration testing mindset
    - Compliance expertise
    - Incident response
    
  tools:
    - SAST scanners
    - Dependency checkers
    - Compliance validators
    - Threat intelligence feeds
```

## Configuration

```yaml
# ~/.nubemclaude/security-config.yaml
security:
  engine:
    enabled: true
    mode: proactive
    auto_fix: true
    
  scanning:
    on_save: true
    on_commit: true
    on_deploy: true
    depth: deep
    
  compliance:
    standards: [OWASP, GDPR]
    enforce: true
    report_format: json
    
  secrets:
    scanner: true
    vault: hashicorp
    rotation_days: 90
    
  monitoring:
    real_time: true
    alerts: true
    incident_response: automated
    
  ml_prediction:
    enabled: true
    model: security_v2
    confidence_threshold: 0.7
```

## Benefits

1. **Proactive Security**: Prevents vulnerabilities before they exist
2. **Automated Compliance**: Always compliant with standards
3. **Zero-Day Protection**: ML predicts unknown vulnerabilities
4. **DevSecOps Native**: Security integrated in development
5. **Enterprise Ready**: Full audit trail and compliance reports

---

*Security First: Making every line of code secure by default*