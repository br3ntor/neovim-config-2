#!/bin/bash
# Neovim Configuration Setup Script
# Supports: Ubuntu, Debian, Arch Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Neovim Configuration Setup${NC}"
echo "Installing system dependencies..."
echo ""

# Install tree-sitter CLI (required for nvim-treesitter main branch with Neovim 0.12+)
install_tree_sitter_cli() {
    if command -v tree-sitter &> /dev/null; then
        echo "tree-sitter CLI already installed"
        return
    fi
    
    echo "Installing tree-sitter CLI..."
    local version="0.26.1"
    local url="https://github.com/tree-sitter/tree-sitter/releases/download/v${version}/tree-sitter-linux-x64.gz"
    
    curl -sL "$url" | gunzip > /tmp/tree-sitter
    chmod +x /tmp/tree-sitter
    sudo mv /tmp/tree-sitter /usr/local/bin/tree-sitter
    echo "tree-sitter CLI installed successfully"
}

install_tree_sitter_cli

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo -e "${RED}Cannot detect OS. Please install dependencies manually.${NC}"
    exit 1
fi

case $OS in
    ubuntu|debian)
        echo -e "${YELLOW}Detected: $OS${NC}"
        echo "Installing packages with apt..."
        sudo apt update
        sudo apt install -y gcc ripgrep fd-find nodejs npm python3 python3-venv make
        # Create symlink for fd if not present (Ubuntu/Debian package installs as fdfind)
        if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
            echo "Creating fd symlink..."
            sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
        fi
        ;;
    arch)
        echo -e "${YELLOW}Detected: Arch Linux${NC}"
        echo "Installing packages with pacman..."
        sudo pacman -Syu --noconfirm gcc ripgrep fd nodejs npm python python-virtualenv make
        ;;
    *)
        echo -e "${RED}Unsupported OS: $OS${NC}"
        echo "Please manually install:"
        echo "  - gcc"
        echo "  - ripgrep"
        echo "  - fd"
        echo "  - nodejs and npm"
        echo "  - python3 and venv"
        echo "  - make"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}System dependencies installed successfully!${NC}"
echo ""
echo "Next steps:"
echo "1. Start Neovim: nvim"
echo "2. Plugins will auto-install on first run"
echo "3. Mason will auto-install LSP servers, formatters, and linters"
echo ""
echo -e "${GREEN}Setup complete!${NC}"
