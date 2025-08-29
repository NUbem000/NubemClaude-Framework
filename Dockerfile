# NubemClaude Framework - Docker Environment
# Multi-stage build for optimal size and security

# Stage 1: Base dependencies
FROM python:3.11-slim as base

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    postgresql-client \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Stage 2: Node.js environment
FROM base as node-env

# Install Node.js 20 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm yarn

# Stage 3: Python environment
FROM node-env as python-env

WORKDIR /app

# Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 4: Framework installation
FROM python-env as framework

# Copy framework files
COPY . /app/

# Install framework components
RUN chmod +x install.sh && \
    ./install.sh --profile complete --non-interactive

# Install MCP servers
RUN npm install -g \
    @modelcontextprotocol/server-filesystem \
    @modelcontextprotocol/server-github \
    @modelcontextprotocol/server-playwright \
    @modelcontextprotocol/server-docker

# Stage 5: Development environment
FROM framework as development

# Development tools
RUN pip install --no-cache-dir \
    pytest \
    black \
    flake8 \
    mypy \
    ipython \
    jupyter

# Install additional dev dependencies
RUN npm install -g \
    eslint \
    prettier \
    typescript \
    @types/node

# Create workspace
WORKDIR /workspace

# Expose ports
EXPOSE 8080 8888 3000 5432 6379

# Development entrypoint
CMD ["/bin/bash"]

# Stage 6: Production environment
FROM framework as production

# Security hardening
RUN useradd -m -s /bin/bash nubemclaude && \
    chown -R nubemclaude:nubemclaude /app

USER nubemclaude

WORKDIR /app

# Production entrypoint
ENTRYPOINT ["python", "-m", "nubemclaude"]
CMD ["serve", "--port", "8080"]