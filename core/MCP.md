# MCP.md - NubemClaude Model Context Protocol Implementation

Sistema completo de Model Context Protocol para interoperabilidad universal con todos los LLMs.

## 🌐 MCP Protocol Architecture

```yaml
protocol_version: "2024.11"
compatibility:
  - Claude (Anthropic)
  - Gemini (Google)
  - GPT/Codex (OpenAI)
  - Ollama (Local)
  - Any MCP-compliant LLM
```

## Core Components

### 1. Resources Management
```typescript
interface Resource {
  uri: string;
  name: string;
  description?: string;
  mimeType?: string;
  metadata?: Record<string, any>;
}

class ResourceManager {
  // File resources
  async getFile(path: string): Resource
  
  // URL resources  
  async getUrl(url: string): Resource
  
  // Database resources
  async getDatabase(query: string): Resource
  
  // API resources
  async getApi(endpoint: string): Resource
}
```

### 2. Tools Registry
```typescript
interface Tool {
  name: string;
  description: string;
  inputSchema: JsonSchema;
  outputSchema?: JsonSchema;
  handler: ToolHandler;
}

class ToolRegistry {
  // Core tools
  registerTool(tool: Tool): void
  getTool(name: string): Tool
  listTools(): Tool[]
  
  // Dynamic tools
  loadPlugin(path: string): void
  unloadPlugin(name: string): void
}
```

### 3. Prompts Repository
```typescript
interface Prompt {
  name: string;
  description: string;
  arguments?: PromptArgument[];
  template: string;
  metadata?: Record<string, any>;
}

class PromptRepository {
  // Prompt management
  addPrompt(prompt: Prompt): void
  getPrompt(name: string): Prompt
  
  // Dynamic prompts
  generatePrompt(context: Context): string
  composePrompts(prompts: string[]): string
}
```

## MCP Servers Configuration

### Built-in Servers

#### Filesystem Server
```yaml
filesystem:
  enabled: true
  roots:
    - path: ~/projects
      name: projects
      writable: true
    - path: /usr/share/doc
      name: documentation
      writable: false
  watch: true
  ignore: [node_modules, .git, __pycache__]
```

#### GitHub Server
```yaml
github:
  enabled: true
  auth: ${GITHUB_TOKEN}
  capabilities:
    - repo_read
    - repo_write
    - issues
    - pull_requests
    - actions
  default_org: NUbem000
```

#### Database Server
```yaml
database:
  enabled: true
  connections:
    postgres:
      url: ${DATABASE_URL}
      ssl: true
    redis:
      url: ${REDIS_URL}
    mongodb:
      url: ${MONGO_URL}
```

#### Brave Search Server
```yaml
brave_search:
  enabled: true
  api_key: ${BRAVE_API_KEY}
  safe_search: moderate
  country: ES
  language: es
```

#### Google Server (Gemini Integration)
```yaml
google:
  enabled: true
  services:
    - search
    - maps
    - drive
    - calendar
  api_key: ${GOOGLE_API_KEY}
  search_grounding: true
  max_results: 10
```

### Community Servers

#### Playwright Server
```yaml
playwright:
  enabled: true
  browsers: [chromium, firefox, webkit]
  headless: true
  screenshots: true
  video: false
```

#### Docker Server
```yaml
docker:
  enabled: true
  socket: /var/run/docker.sock
  capabilities:
    - containers
    - images
    - networks
    - volumes
  auto_remove: true
```

#### Kubernetes Server
```yaml
kubernetes:
  enabled: false
  config: ~/.kube/config
  namespace: default
  watch: true
```

## Plugin Architecture

### Plugin Structure
```
plugins/
├── security-scanner/
│   ├── manifest.json
│   ├── index.js
│   ├── tools.json
│   └── prompts.json
├── code-predictor/
│   ├── manifest.json
│   ├── index.py
│   └── models/
└── custom-plugin/
    └── ...
```

### Plugin Manifest
```json
{
  "name": "security-scanner",
  "version": "1.0.0",
  "description": "Advanced security scanning plugin",
  "author": "NubemSystems",
  "mcp": {
    "tools": ["scan", "audit", "fix"],
    "resources": ["security-db"],
    "prompts": ["security-review"]
  },
  "dependencies": {
    "semgrep": "^1.0.0",
    "snyk": "^1.0.0"
  },
  "permissions": [
    "filesystem:read",
    "network:fetch"
  ]
}
```

### Plugin API
```python
from nubemclaude.mcp import Plugin, Tool, Resource

class SecurityScannerPlugin(Plugin):
    def __init__(self):
        super().__init__("security-scanner")
        
    @Tool("scan", "Scan code for vulnerabilities")
    async def scan_code(self, path: str, deep: bool = False):
        # Implementation
        return scan_results
        
    @Resource("security-db")
    async def get_vulnerability_db(self):
        # Return vulnerability database
        return db_resource
```

## Interoperability Layer

### Universal Client
```python
class MCPClient:
    def __init__(self, provider: str):
        self.provider = self._load_provider(provider)
        
    async def execute_tool(self, tool: str, **params):
        """Execute tool on any MCP-compliant provider"""
        return await self.provider.call_tool(tool, params)
        
    async def get_resource(self, uri: str):
        """Get resource from any provider"""
        return await self.provider.fetch_resource(uri)
        
    async def apply_prompt(self, prompt: str, **args):
        """Apply prompt template"""
        return await self.provider.use_prompt(prompt, args)
```

### Provider Adapters
```python
class ClaudeAdapter(MCPProvider):
    """Adapter for Claude/Anthropic"""
    async def call_tool(self, tool, params):
        # Claude-specific implementation
        pass

class GeminiAdapter(MCPProvider):
    """Adapter for Google Gemini"""
    async def call_tool(self, tool, params):
        # Gemini-specific implementation
        pass

class OpenAIAdapter(MCPProvider):
    """Adapter for OpenAI/Codex"""
    async def call_tool(self, tool, params):
        # OpenAI-specific implementation
        pass
```

## Security & Permissions

### Permission Model
```yaml
permissions:
  levels:
    - read: Read-only access
    - write: Read and write access
    - execute: Can execute commands
    - admin: Full control
    
  scopes:
    - filesystem: File system access
    - network: Network requests
    - database: Database access
    - system: System commands
    - sensitive: Access to secrets
```

### OAuth 2.1 Integration
```yaml
oauth:
  enabled: true
  provider: auth0
  client_id: ${OAUTH_CLIENT_ID}
  scopes:
    - openid
    - profile
    - email
    - mcp:read
    - mcp:write
  multi_tenant: true
```

## Communication Protocol

### Request/Response Format
```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "scan_code",
    "arguments": {
      "path": "/project",
      "deep": true
    }
  },
  "id": "req_123"
}
```

### Streaming Support
```python
async def stream_response(tool_name: str, params: dict):
    async for chunk in mcp_client.stream_tool(tool_name, **params):
        yield {
            "type": "stream",
            "data": chunk,
            "progress": chunk.progress
        }
```

## Integration with NubemClaude

### Auto-MCP Detection
```python
def detect_mcp_need(command: str, context: dict) -> list[str]:
    """Automatically detect which MCP servers are needed"""
    servers = []
    
    if "github" in command or "PR" in command:
        servers.append("github")
    if "search" in command or "find online" in command:
        servers.append("brave_search")
    if "docker" in command or "container" in command:
        servers.append("docker")
    if needs_browser_automation(command):
        servers.append("playwright")
        
    return servers
```

### MCP-Enhanced Commands
```bash
# Uses GitHub MCP server
/nc:github-review PR#123

# Uses Brave Search + Google
/nc:research "latest AI trends"

# Uses Docker MCP
/nc:containerize --optimize

# Uses multiple MCP servers
/nc:deploy --full-stack
```

## Configuration

### Main MCP Config
```yaml
# ~/.nubemclaude/mcp-config.yaml
mcp:
  version: "2024.11"
  
  # Provider settings
  default_provider: claude
  multi_provider: true
  
  # Server settings
  servers:
    filesystem:
      enabled: true
    github:
      enabled: true
      token: ${GITHUB_TOKEN}
    google:
      enabled: true
      api_key: ${GOOGLE_API_KEY}
    brave_search:
      enabled: false
    docker:
      enabled: false
      
  # Plugin settings
  plugins:
    directory: ~/.nubemclaude/plugins
    auto_load: true
    marketplace: https://plugins.nubemclaude.dev
    
  # Security
  security:
    sandbox: true
    permissions_check: strict
    audit_log: true
    
  # Performance
  performance:
    cache: true
    cache_ttl: 3600
    parallel_requests: 3
    timeout: 30
```

## Marketplace Integration

### Plugin Discovery
```python
async def search_plugins(query: str):
    """Search plugin marketplace"""
    marketplace = MCPMarketplace()
    return await marketplace.search(
        query=query,
        sort="downloads",
        verified_only=True
    )

async def install_plugin(name: str):
    """Install plugin from marketplace"""
    plugin = await marketplace.get(name)
    await plugin.download()
    await plugin.install()
    await plugin.enable()
```

## Benefits

1. **Universal Compatibility**: Works with any MCP-compliant LLM
2. **Extensible**: Easy to add new servers and plugins
3. **Secure**: Permission model and sandboxing
4. **Performant**: Caching and parallel execution
5. **Enterprise Ready**: OAuth 2.1 and multi-tenancy

---

*MCP: Making NubemClaude truly universal and extensible*