#!/bin/bash
# ============================================================================
# Neovim Configuration Installation Script
# For Rust & Assembly x86_64 Development
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    local missing_deps=()
    
    # Check Neovim
    if command -v nvim &> /dev/null; then
        NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
        print_success "Neovim found: $NVIM_VERSION"
    else
        print_error "Neovim not found"
        missing_deps+=("neovim")
    fi
    
    # Check Git
    if command -v git &> /dev/null; then
        print_success "Git found: $(git --version | cut -d' ' -f3)"
    else
        print_error "Git not found"
        missing_deps+=("git")
    fi
    
    # Check ripgrep (optional but recommended)
    if command -v rg &> /dev/null; then
        print_success "ripgrep found"
    else
        print_warning "ripgrep not found (recommended for Telescope)"
    fi
    
    # Check fd (optional)
    if command -v fd &> /dev/null || command -v fdfind &> /dev/null; then
        print_success "fd found"
    else
        print_warning "fd not found (optional, improves file finding)"
    fi
    
    # Check Node.js (for Copilot)
    if command -v node &> /dev/null; then
        print_success "Node.js found: $(node --version)"
    else
        print_warning "Node.js not found (required for GitHub Copilot)"
    fi
    
    # Check Rust (for Rust development)
    if command -v rustc &> /dev/null; then
        print_success "Rust found: $(rustc --version | cut -d' ' -f2)"
    else
        print_warning "Rust not found (required for Rust development)"
    fi
    
    # Check NASM (for Assembly)
    if command -v nasm &> /dev/null; then
        print_success "NASM found: $(nasm -version | head -n1)"
    else
        print_warning "NASM not found (required for Assembly development)"
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        echo ""
        echo "Please install missing dependencies and run this script again."
        exit 1
    fi
    
    echo ""
    print_info "All required dependencies are installed!"
}

# Backup existing configuration
backup_config() {
    print_header "Backing Up Existing Configuration"
    
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local backed_up=false
    
    # Backup config directory
    if [ -d "$HOME/.config/nvim" ]; then
        mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$TIMESTAMP"
        print_success "Backed up ~/.config/nvim"
        backed_up=true
    fi
    
    # Backup data directory
    if [ -d "$HOME/.local/share/nvim" ]; then
        mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.backup.$TIMESTAMP"
        print_success "Backed up ~/.local/share/nvim"
        backed_up=true
    fi
    
    # Backup cache directory
    if [ -d "$HOME/.cache/nvim" ]; then
        mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.backup.$TIMESTAMP"
        print_success "Backed up ~/.cache/nvim"
        backed_up=true
    fi
    
    # Backup state directory
    if [ -d "$HOME/.local/state/nvim" ]; then
        mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.backup.$TIMESTAMP"
        print_success "Backed up ~/.local/state/nvim"
        backed_up=true
    fi
    
    if [ "$backed_up" = true ]; then
        echo ""
        print_success "Backup complete! Timestamp: $TIMESTAMP"
        print_info "To restore: mv ~/.config/nvim.backup.$TIMESTAMP ~/.config/nvim"
        echo ""
        echo "BACKUP_TIMESTAMP=$TIMESTAMP" > "$HOME/.nvim_backup_info"
    else
        print_info "No existing configuration found. Proceeding with fresh installation."
    fi
}

# Install configuration
install_config() {
    print_header "Installing Neovim Configuration"
    
    # Get script directory
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Check if .config/nvim exists in current directory or parent
    if [ -d "$SCRIPT_DIR/.config/nvim" ]; then
        CONFIG_SOURCE="$SCRIPT_DIR/.config/nvim"
    elif [ -d "$SCRIPT_DIR/../.config/nvim" ]; then
        CONFIG_SOURCE="$SCRIPT_DIR/../.config/nvim"
    else
        print_error "Cannot find .config/nvim directory"
        echo "Please run this script from the repository root or .config directory"
        exit 1
    fi
    
    # Create config directory
    mkdir -p "$HOME/.config"
    
    # Copy configuration
    print_info "Copying configuration files..."
    cp -r "$CONFIG_SOURCE" "$HOME/.config/nvim"
    print_success "Configuration files copied to ~/.config/nvim"
    
    echo ""
    print_success "Installation complete!"
}

# Post-installation instructions
post_install() {
    print_header "Post-Installation Steps"
    
    echo "1. Launch Neovim:"
    echo "   ${GREEN}nvim${NC}"
    echo ""
    echo "2. Plugins will install automatically (wait 2-5 minutes)"
    echo ""
    echo "3. Install LSP servers (after plugins install):"
    echo "   ${GREEN}:Mason${NC}"
    echo ""
    echo "4. Set up GitHub Copilot:"
    echo "   ${GREEN}:Copilot setup${NC}"
    echo ""
    echo "5. Test the configuration:"
    echo "   - Create a Rust file: ${GREEN}nvim test.rs${NC}"
    echo "   - Toggle transparent background: ${GREEN}<Space>tb${NC}"
    echo "   - Open file explorer: ${GREEN}<Space>e${NC}"
    echo ""
    
    if [ -f "$HOME/.nvim_backup_info" ]; then
        source "$HOME/.nvim_backup_info"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        print_info "To restore your old configuration:"
        echo "   ${YELLOW}rm -rf ~/.config/nvim${NC}"
        echo "   ${YELLOW}mv ~/.config/nvim.backup.$BACKUP_TIMESTAMP ~/.config/nvim${NC}"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
    fi
    
    print_success "Ready to code! 🚀"
    echo ""
    echo "For help, see: ~/.config/nvim/README.md"
}

# Main installation flow
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                    ║"
    echo "║     Neovim Configuration Installer                                 ║"
    echo "║     Rust & Assembly x86_64 Development                             ║"
    echo "║                                                                    ║"
    echo "╚════════════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Ask for confirmation
    read -p "$(echo -e ${YELLOW}This will backup your existing Neovim config and install the new one. Continue? [y/N]: ${NC})" -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled."
        exit 0
    fi
    
    check_prerequisites
    backup_config
    install_config
    post_install
}

# Run main function
main
