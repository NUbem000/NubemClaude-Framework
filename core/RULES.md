# RULES.md - NubemClaude Universal Rules System

Sistema universal de reglas compatible con Claude Code, Cursor, Windsurf y cualquier IDE con IA.

## 🎯 Universal Compatibility

```yaml
compatibility:
  claude_code: ✅
  cursor: ✅ 
  windsurf: ✅
  cline: ✅
  continue: ✅
  cody: ✅
  github_copilot: ✅
  jetbrains_ai: ✅
```

## Core Rules

### 1. Code Quality Standards
```yaml
code_quality:
  naming:
    - Use descriptive names (min 3 chars, max 40)
    - camelCase for JS/TS variables
    - snake_case for Python
    - PascalCase for classes
    - SCREAMING_SNAKE_CASE for constants
    
  structure:
    - Single responsibility principle
    - Max function length: 50 lines
    - Max file length: 500 lines
    - Max complexity: 10
    
  documentation:
    - JSDoc/PyDoc for public APIs
    - Inline comments for complex logic
    - README for every module
    - ADRs for architectural decisions
```

### 2. Development Workflow
```yaml
workflow:
  before_coding:
    - Understand requirements fully
    - Check existing implementations
    - Design before implement
    - Consider edge cases
    
  while_coding:
    - Write tests first (TDD)
    - Commit often, push regularly
    - Keep changes atomic
    - Refactor continuously
    
  after_coding:
    - Run all tests
    - Update documentation
    - Request code review
    - Monitor performance
```

### 3. Security Rules
```yaml
security:
  never:
    - Hardcode secrets or passwords
    - Use eval() or exec() with user input
    - Disable SSL verification
    - Log sensitive data
    - Trust user input without validation
    
  always:
    - Sanitize all inputs
    - Use parameterized queries
    - Encrypt sensitive data
    - Follow OWASP guidelines
    - Keep dependencies updated
```

### 4. Performance Guidelines
```yaml
performance:
  database:
    - Use indexes appropriately
    - Avoid N+1 queries
    - Implement pagination
    - Cache frequently accessed data
    
  frontend:
    - Lazy load components
    - Optimize images
    - Minimize bundle size
    - Use CDN for static assets
    
  backend:
    - Implement rate limiting
    - Use connection pooling
    - Async/await for I/O operations
    - Profile before optimizing
```

### 5. Git Conventions
```yaml
git:
  commits:
    format: "<type>(<scope>): <subject>"
    types: [feat, fix, docs, style, refactor, test, chore]
    max_length: 72
    
  branches:
    feature: feature/<ticket>-<description>
    bugfix: bugfix/<ticket>-<description>
    hotfix: hotfix/<ticket>-<description>
    release: release/<version>
    
  pull_requests:
    - Link to issue/ticket
    - Include tests
    - Update documentation
    - Pass CI/CD checks
```

## Language-Specific Rules

### JavaScript/TypeScript
```typescript
// Always use strict types
interface User {
  id: string;
  name: string;
  email: string;
}

// Prefer const over let
const MAX_RETRIES = 3;

// Use async/await over promises
async function fetchUser(id: string): Promise<User> {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    logger.error('Failed to fetch user', { id, error });
    throw new UserNotFoundError(id);
  }
}

// Always handle errors
try {
  await riskyOperation();
} catch (error) {
  // Handle specific error types
  if (error instanceof NetworkError) {
    await retry(riskyOperation);
  } else {
    throw error;
  }
}
```

### Python
```python
# Use type hints
from typing import List, Optional, Dict

def process_data(
    items: List[str],
    config: Optional[Dict[str, any]] = None
) -> Dict[str, any]:
    """Process data items according to config.
    
    Args:
        items: List of items to process
        config: Optional configuration dict
        
    Returns:
        Processed data as dictionary
        
    Raises:
        ValueError: If items is empty
    """
    if not items:
        raise ValueError("Items cannot be empty")
    
    config = config or {}
    
    # Use list comprehensions
    processed = [
        transform(item, config) 
        for item in items 
        if validate(item)
    ]
    
    return {"data": processed, "count": len(processed)}

# Use context managers
with open('file.txt', 'r') as f:
    content = f.read()

# Use dataclasses
from dataclasses import dataclass

@dataclass
class Config:
    timeout: int = 30
    retries: int = 3
    debug: bool = False
```

### React/Vue
```jsx
// React: Use functional components
import React, { useState, useEffect } from 'react';

const UserProfile = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  useEffect(() => {
    fetchUser(userId)
      .then(setUser)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [userId]);
  
  if (loading) return <Spinner />;
  if (error) return <ErrorMessage error={error} />;
  if (!user) return <NotFound />;
  
  return (
    <div className="user-profile">
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};

// Vue: Use Composition API
<script setup>
import { ref, onMounted } from 'vue';

const props = defineProps(['userId']);
const user = ref(null);
const loading = ref(true);
const error = ref(null);

onMounted(async () => {
  try {
    user.value = await fetchUser(props.userId);
  } catch (e) {
    error.value = e;
  } finally {
    loading.value = false;
  }
});
</script>
```

## Testing Standards
```yaml
testing:
  coverage:
    minimum: 80%
    target: 95%
    
  types:
    unit: All business logic
    integration: API endpoints
    e2e: Critical user flows
    performance: Heavy operations
    
  naming:
    pattern: "should_<expected>_when_<condition>"
    
  structure:
    - Arrange: Set up test data
    - Act: Execute the function
    - Assert: Verify the result
```

## API Design
```yaml
api:
  rest:
    - Use proper HTTP methods
    - Return appropriate status codes
    - Version your APIs (/api/v1/)
    - Implement pagination
    - Use consistent naming
    
  graphql:
    - Define clear schemas
    - Implement DataLoader
    - Handle errors gracefully
    - Optimize queries
    
  responses:
    success:
      status: 200/201
      body: { data: {}, meta: {} }
    error:
      status: 4xx/5xx
      body: { error: { code, message, details } }
```

## Database Guidelines
```sql
-- Always use migrations
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for frequently queried columns
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at DESC);

-- Use transactions for multiple operations
BEGIN;
INSERT INTO users (email, name) VALUES ($1, $2);
INSERT INTO profiles (user_id, bio) VALUES ($3, $4);
COMMIT;
```

## DevOps Rules
```yaml
devops:
  docker:
    - Multi-stage builds
    - Non-root user
    - Minimal base images
    - Layer caching optimization
    
  kubernetes:
    - Resource limits
    - Health checks
    - Rolling updates
    - Secret management
    
  ci_cd:
    - Automated tests
    - Security scanning
    - Code quality checks
    - Automated deployments
```

## Documentation Requirements
```yaml
documentation:
  required:
    - README.md with setup instructions
    - API documentation (OpenAPI/Swagger)
    - Architecture diagrams
    - Deployment guide
    - Contributing guidelines
    
  format:
    - Use Markdown
    - Include examples
    - Keep it updated
    - Version with code
```

## Cross-Platform Configuration

### .cursorrules (Cursor)
```yaml
# Automatically created from RULES.md
chat_preferences:
  style: concise
  technical_level: expert
  
code_generation:
  language: detect_from_context
  style: clean_code
  testing: include_tests
```

### .windsurf (Windsurf)
```yaml
# Automatically created from RULES.md
ai_assistant:
  personality: professional
  verbosity: medium
  
code_style:
  formatter: prettier
  linter: eslint
```

### .cline (CLINE)
```yaml
# Automatically created from RULES.md
behavior:
  auto_complete: true
  explain_changes: true
  
preferences:
  language: english
  format: markdown
```

## Rule Priorities

1. **🔴 Critical** - Security, data integrity
2. **🟡 Important** - Performance, maintainability  
3. **🟢 Recommended** - Code style, conventions

## Auto-Enforcement

The framework automatically:
- Validates rules on save
- Fixes simple violations
- Warns about complex issues
- Blocks critical violations
- Generates reports

## Customization

Create project-specific rules in:
```
project/
├── .nubemclaude/
│   └── rules.yaml  # Project overrides
└── RULES.md        # Project documentation
```

## Integration Commands

```bash
# Validate rules
/nc:validate-rules

# Auto-fix violations
/nc:fix-rules

# Generate rules report
/nc:rules-report

# Sync rules to IDEs
/nc:sync-rules
```

---

*Universal rules for consistent, high-quality development across all AI-powered IDEs*