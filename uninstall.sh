#!/bin/bash
# ============================================================================
# Neovim Configuration Uninstall Script
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

echo ""
echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                                                                    ║"
echo "║     Neovim Configuration Uninstaller                               ║"
echo "║                                                                    ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

print_warning "This will remove your current Neovim configuration!"
echo ""
echo "The following directories will be removed:"
echo "  - ~/.config/nvim"
echo "  - ~/.local/share/nvim"
echo "  - ~/.cache/nvim"
echo "  - ~/.local/state/nvim"
echo ""

# Check for backups
if [ -f "$HOME/.nvim_backup_info" ]; then
    source "$HOME/.nvim_backup_info"
    print_info "Found backup from: $BACKUP_TIMESTAMP"
    echo ""
    read -p "$(echo -e ${GREEN}Would you like to restore your backup? [y/N]: ${NC})" -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Restore backup
        echo ""
        print_info "Restoring backup..."
        
        rm -rf "$HOME/.config/nvim"
        rm -rf "$HOME/.local/share/nvim"
        rm -rf "$HOME/.cache/nvim"
        rm -rf "$HOME/.local/state/nvim"
        
        [ -d "$HOME/.config/nvim.backup.$BACKUP_TIMESTAMP" ] && \
            mv "$HOME/.config/nvim.backup.$BACKUP_TIMESTAMP" "$HOME/.config/nvim" && \
            print_success "Restored ~/.config/nvim"
        
        [ -d "$HOME/.local/share/nvim.backup.$BACKUP_TIMESTAMP" ] && \
            mv "$HOME/.local/share/nvim.backup.$BACKUP_TIMESTAMP" "$HOME/.local/share/nvim" && \
            print_success "Restored ~/.local/share/nvim"
        
        [ -d "$HOME/.cache/nvim.backup.$BACKUP_TIMESTAMP" ] && \
            mv "$HOME/.cache/nvim.backup.$BACKUP_TIMESTAMP" "$HOME/.cache/nvim" && \
            print_success "Restored ~/.cache/nvim"
        
        [ -d "$HOME/.local/state/nvim.backup.$BACKUP_TIMESTAMP" ] && \
            mv "$HOME/.local/state/nvim.backup.$BACKUP_TIMESTAMP" "$HOME/.local/state/nvim" && \
            print_success "Restored ~/.local/state/nvim"
        
        rm "$HOME/.nvim_backup_info"
        
        echo ""
        print_success "Backup restored successfully!"
        exit 0
    fi
fi

echo ""
read -p "$(echo -e ${RED}Are you sure you want to remove Neovim configuration? [y/N]: ${NC})" -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Uninstallation cancelled."
    exit 0
fi

# Remove configuration
echo ""
print_info "Removing Neovim configuration..."

if [ -d "$HOME/.config/nvim" ]; then
    rm -rf "$HOME/.config/nvim"
    print_success "Removed ~/.config/nvim"
fi

if [ -d "$HOME/.local/share/nvim" ]; then
    rm -rf "$HOME/.local/share/nvim"
    print_success "Removed ~/.local/share/nvim"
fi

if [ -d "$HOME/.cache/nvim" ]; then
    rm -rf "$HOME/.cache/nvim"
    print_success "Removed ~/.cache/nvim"
fi

if [ -d "$HOME/.local/state/nvim" ]; then
    rm -rf "$HOME/.local/state/nvim"
    print_success "Removed ~/.local/state/nvim"
fi

[ -f "$HOME/.nvim_backup_info" ] && rm "$HOME/.nvim_backup_info"

echo ""
print_success "Neovim configuration removed successfully!"
echo ""
print_info "You can reinstall anytime by running: ./install.sh"
echo ""
