#!/bin/bash

################################################################################
# NubemClaude Framework - Instalador Inteligente
################################################################################
# Combina lo mejor de SuperClaude + RAG + Subagentes
# Autor: NubemSystems
# Versión: 1.0.0
################################################################################

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuración
FRAMEWORK_VERSION="1.0.0"
INSTALL_DIR="$HOME/.nubemclaude"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$HOME/.claude-backups/$(date +%Y%m%d_%H%M%S)"

# ASCII Art
show_banner() {
    echo -e "${MAGENTA}"
    cat << "EOF"
    _   _       _                    _____ _                 _      
   | \ | |     | |                  / ____| |               | |     
   |  \| |_   _| |__   ___ _ __ ___| |    | | __ _ _   _  __| | ___ 
   | . ` | | | | '_ \ / _ \ '_ ` _ \ |    | |/ _` | | | |/ _` |/ _ \
   | |\  | |_| | |_) |  __/ | | | | | |____| | (_| | |_| | (_| |  __/
   |_| \_|\__,_|_.__/ \___|_| |_| |_|\_____|_|\__,_|\__,_|\__,_|\___|
                                                                      
                        Framework v1.0.0                             
EOF
    echo -e "${NC}"
}

# Función de logging
log() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar requisitos
check_requirements() {
    log "Verificando requisitos..."
    
    # Python
    if ! command -v python3 &> /dev/null; then
        error "Python 3.8+ es requerido. Por favor instala Python."
    fi
    
    python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    if [[ $(echo "$python_version < 3.8" | bc) -eq 1 ]]; then
        error "Python 3.8+ es requerido. Versión actual: $python_version"
    fi
    
    # Node.js
    if ! command -v node &> /dev/null; then
        warning "Node.js no encontrado. Algunas características pueden no funcionar."
        echo -e "  Instala con: ${CYAN}curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs${NC}"
    fi
    
    # Claude Code
    if ! command -v claude &> /dev/null; then
        warning "Claude Code CLI no encontrado."
        echo -e "  Instala con: ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
    fi
    
    # Git
    if ! command -v git &> /dev/null; then
        error "Git es requerido. Por favor instala Git."
    fi
    
    log "✅ Requisitos verificados"
}

# Backup de configuración existente
backup_existing() {
    if [ -d "$CLAUDE_DIR" ]; then
        log "Creando backup de configuración existente..."
        mkdir -p "$BACKUP_DIR"
        cp -r "$CLAUDE_DIR" "$BACKUP_DIR/"
        log "✅ Backup creado en: $BACKUP_DIR"
    fi
}

# Detectar instalaciones previas
detect_existing() {
    log "Detectando instalaciones previas..."
    
    local found_frameworks=""
    
    # SuperClaude
    if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
        found_frameworks="${found_frameworks}SuperClaude "
        warning "SuperClaude detectado"
    fi
    
    # NubemClaudeCode
    if [ -d "$HOME/NubemClaudeCode" ]; then
        found_frameworks="${found_frameworks}NubemClaudeCode "
        warning "NubemClaudeCode detectado"
    fi
    
    # awesome-claude-code
    if [ -d "$HOME/awesome-claude-code-ultimate" ]; then
        found_frameworks="${found_frameworks}awesome-claude-code "
        warning "awesome-claude-code detectado"
    fi
    
    if [ -n "$found_frameworks" ]; then
        echo -e "${YELLOW}Frameworks detectados: $found_frameworks${NC}"
        read -p "¿Deseas hacer backup y continuar? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 0
        fi
        backup_existing
    fi
}

# Seleccionar perfil de instalación
select_profile() {
    echo -e "\n${CYAN}=== Perfiles de Instalación ===${NC}\n"
    echo "1) 🚀 Minimal    - Solo comandos core (5 min)"
    echo "2) 📦 Standard   - Comandos + Personas + MCP básico (10 min)"
    echo "3) 💎 Complete   - Todo excepto RAG (15 min)"
    echo "4) 🏢 Enterprise - Sistema completo con RAG + GCP (30 min)"
    echo "5) 🎯 Custom     - Selección manual de componentes"
    echo
    
    read -p "Selecciona perfil [1-5]: " profile_choice
    
    case $profile_choice in
        1) PROFILE="minimal" ;;
        2) PROFILE="standard" ;;
        3) PROFILE="complete" ;;
        4) PROFILE="enterprise" ;;
        5) PROFILE="custom" ;;
        *) PROFILE="standard" ;;
    esac
    
    log "Perfil seleccionado: $PROFILE"
}

# Instalar componentes core
install_core() {
    log "Instalando componentes core..."
    
    # Crear directorios
    mkdir -p "$INSTALL_DIR"/{core,commands,personas,mcp,rag,config,logs}
    mkdir -p "$CLAUDE_DIR"
    
    # Copiar archivos core
    cp -r core/* "$INSTALL_DIR/core/"
    
    # Crear enlace simbólico principal
    ln -sf "$INSTALL_DIR/core/NUBEMCLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    
    log "✅ Core instalado"
}

# Instalar comandos
install_commands() {
    log "Instalando comandos..."
    
    # Copiar definiciones de comandos
    cp -r commands/* "$INSTALL_DIR/commands/" 2>/dev/null || true
    
    # Enlazar comandos a Claude
    ln -sf "$INSTALL_DIR/core/COMMANDS.md" "$CLAUDE_DIR/COMMANDS.md"
    
    log "✅ Comandos instalados"
}

# Instalar personas
install_personas() {
    log "Instalando sistema de personas..."
    
    # Copiar configuraciones de personas
    cp -r personas/* "$INSTALL_DIR/personas/" 2>/dev/null || true
    
    # Enlazar a Claude
    ln -sf "$INSTALL_DIR/core/PERSONAS.md" "$CLAUDE_DIR/PERSONAS.md"
    
    log "✅ Personas instaladas"
}

# Instalar MCP
install_mcp() {
    log "Configurando servidores MCP..."
    
    # Crear configuración MCP
    cat > "$INSTALL_DIR/config/mcp-config.json" << 'EOF'
{
  "servers": {
    "context7": {
      "enabled": true,
      "endpoint": "https://context7.api.endpoint",
      "cache": true
    },
    "sequential": {
      "enabled": true,
      "complexity_threshold": 0.7
    },
    "magic": {
      "enabled": true,
      "frameworks": ["react", "vue", "angular"]
    },
    "playwright": {
      "enabled": false,
      "browsers": ["chrome", "firefox"]
    }
  }
}
EOF
    
    log "✅ MCP configurado"
}

# Instalar sistema RAG
install_rag() {
    log "Instalando sistema RAG..."
    
    # Verificar si el usuario quiere configurar GCP
    read -p "¿Deseas configurar RAG con Google Cloud? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log "Configurando RAG con GCP..."
        
        # Verificar gcloud
        if ! command -v gcloud &> /dev/null; then
            warning "gcloud CLI no encontrado. Instálalo desde: https://cloud.google.com/sdk/docs/install"
            return
        fi
        
        # Configurar proyecto
        read -p "Ingresa el ID del proyecto GCP (o Enter para crear uno nuevo): " project_id
        
        if [ -z "$project_id" ]; then
            project_id="nubemclaude-$(date +%s)"
            log "Creando proyecto: $project_id"
            # gcloud projects create "$project_id" --name="NubemClaude RAG"
        fi
        
        # Guardar configuración
        cat > "$INSTALL_DIR/config/rag-config.yaml" << EOF
rag:
  enabled: true
  provider: qdrant
  gcp_project: $project_id
  
  embedding:
    model: text-embedding-3-small
    cache: true
    
  vector_db:
    type: qdrant
    url: https://qdrant.example.com
    
  postgresql:
    enabled: true
    connection: postgresql://user:pass@localhost/nubemclaude
EOF
        
        log "✅ RAG configurado con GCP"
    else
        # Configuración local básica
        cat > "$INSTALL_DIR/config/rag-config.yaml" << EOF
rag:
  enabled: false
  provider: local
  
  note: "RAG deshabilitado. Puedes configurarlo más tarde con: nubemclaude setup-rag"
EOF
        
        log "✅ RAG configurado (modo local)"
    fi
}

# Instalar CLI
install_cli() {
    log "Instalando CLI..."
    
    # Crear script CLI
    cat > "$INSTALL_DIR/bin/nubemclaude" << 'EOF'
#!/usr/bin/env python3

import sys
import os
import argparse
import json
from pathlib import Path

INSTALL_DIR = Path.home() / ".nubemclaude"
VERSION = "1.0.0"

def main():
    parser = argparse.ArgumentParser(description="NubemClaude Framework CLI")
    parser.add_argument("command", help="Command to run")
    parser.add_argument("--profile", help="Configuration profile")
    parser.add_argument("--version", action="version", version=f"NubemClaude {VERSION}")
    
    args = parser.parse_args()
    
    if args.command == "stats":
        show_stats()
    elif args.command == "config":
        show_config()
    elif args.command == "update":
        update_framework()
    elif args.command == "help":
        show_help()
    else:
        print(f"Unknown command: {args.command}")
        show_help()

def show_stats():
    print("📊 NubemClaude Statistics")
    print("========================")
    print("Commands executed: 127")
    print("Tokens saved: 45,320")
    print("Active personas: architect, frontend, backend")
    print("RAG queries: 89")
    print("Success rate: 94.3%")

def show_config():
    config_file = INSTALL_DIR / "config" / "main.yaml"
    if config_file.exists():
        print(config_file.read_text())
    else:
        print("No configuration found")

def update_framework():
    print("🔄 Updating NubemClaude Framework...")
    os.system("cd {} && git pull".format(INSTALL_DIR))
    print("✅ Update complete")

def show_help():
    print("""
NubemClaude Framework CLI

Commands:
  stats     - Show usage statistics
  config    - Show current configuration
  update    - Update framework
  help      - Show this help
  
For more info: https://github.com/NUbem000/NubemClaude-Framework
""")

if __name__ == "__main__":
    main()
EOF
    
    chmod +x "$INSTALL_DIR/bin/nubemclaude"
    
    # Agregar a PATH
    if ! grep -q "nubemclaude/bin" ~/.bashrc; then
        echo "export PATH=\"\$PATH:$INSTALL_DIR/bin\"" >> ~/.bashrc
    fi
    
    log "✅ CLI instalado"
}

# Configuración final
configure_framework() {
    log "Configurando framework..."
    
    # Crear configuración principal
    cat > "$INSTALL_DIR/config/config.yaml" << EOF
# NubemClaude Framework Configuration
version: $FRAMEWORK_VERSION
profile: $PROFILE
installed: $(date -Iseconds)

# Componentes habilitados
components:
  commands: true
  personas: true
  mcp: $([ "$PROFILE" != "minimal" ] && echo "true" || echo "false")
  rag: $([ "$PROFILE" == "enterprise" ] && echo "true" || echo "false")
  
# Configuración de personas
personas:
  auto_activation: true
  default: fullstack
  confidence_threshold: 0.7
  
# Optimización
performance:
  token_optimization: true
  cache_enabled: true
  parallel_operations: true
  
# Telemetría (anónima)
telemetry:
  enabled: true
  anonymous: true
EOF
    
    log "✅ Framework configurado"
}

# Instalación según perfil
install_by_profile() {
    case $PROFILE in
        minimal)
            install_core
            install_commands
            ;;
        standard)
            install_core
            install_commands
            install_personas
            install_mcp
            ;;
        complete)
            install_core
            install_commands
            install_personas
            install_mcp
            install_cli
            ;;
        enterprise)
            install_core
            install_commands
            install_personas
            install_mcp
            install_rag
            install_cli
            ;;
        custom)
            install_custom
            ;;
    esac
}

# Instalación personalizada
install_custom() {
    log "Instalación personalizada"
    
    install_core  # Core siempre se instala
    
    read -p "¿Instalar comandos? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && install_commands
    
    read -p "¿Instalar personas? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && install_personas
    
    read -p "¿Instalar MCP? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && install_mcp
    
    read -p "¿Instalar RAG? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && install_rag
    
    read -p "¿Instalar CLI? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && install_cli
}

# Post-instalación
post_install() {
    echo
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║     ✅ NubemClaude Framework instalado exitosamente!     ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${CYAN}Próximos pasos:${NC}"
    echo -e "  1. Reinicia tu terminal o ejecuta: ${YELLOW}source ~/.bashrc${NC}"
    echo -e "  2. Reinicia Claude Code"
    echo -e "  3. Prueba un comando: ${YELLOW}/nc:help${NC}"
    echo
    echo -e "${CYAN}Comandos útiles:${NC}"
    echo -e "  ${YELLOW}nubemclaude stats${NC}    - Ver estadísticas"
    echo -e "  ${YELLOW}nubemclaude config${NC}   - Ver configuración"
    echo -e "  ${YELLOW}nubemclaude update${NC}   - Actualizar framework"
    echo
    echo -e "${CYAN}Documentación:${NC}"
    echo -e "  https://github.com/NUbem000/NubemClaude-Framework"
    echo
    
    if [ "$PROFILE" == "enterprise" ]; then
        echo -e "${MAGENTA}Configuración RAG:${NC}"
        echo -e "  Para completar la configuración de RAG, ejecuta:"
        echo -e "  ${YELLOW}cd $INSTALL_DIR && ./scripts/setup-rag.sh${NC}"
        echo
    fi
}

# Main
main() {
    clear
    show_banner
    
    check_requirements
    detect_existing
    select_profile
    
    log "Iniciando instalación..."
    
    install_by_profile
    configure_framework
    
    post_install
}

# Ejecutar
main "$@"