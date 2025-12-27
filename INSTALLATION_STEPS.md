# Step-by-Step Installation Guide

This guide provides detailed instructions for installing the Neovim configuration, including how to backup your existing configuration.

## Table of Contents
0. [Getting the Configuration](#getting-the-configuration)
1. [Prerequisites](#prerequisites)
2. [Backup Existing Configuration](#backup-existing-configuration)
3. [Installation Methods](#installation-methods)
4. [First Launch](#first-launch)
5. [Post-Installation Setup](#post-installation-setup)
6. [Verification](#verification)
7. [Troubleshooting](#troubleshooting)
8. [Restoration](#restoration)

---

## Getting the Configuration

Before you can install the Neovim configuration, you need to download it from the repository.

```bash
# Clone the repository
git clone https://github.com/paolocampomail-cloud/zero2prod.git
cd zero2prod
```

Now you have the configuration files in `zero2prod/.config/nvim/`.

**Note**: All subsequent commands in this guide assume you're in the `zero2prod` directory.

---

## Prerequisites

Before installing, ensure you have:

### Required
- **Neovim >= 0.9.0**
- **Git**
- **A Nerd Font** (JetBrainsMono, FiraCode, or Hack recommended)
- **ripgrep** (for Telescope search)
- **Node.js >= 16** (for GitHub Copilot)

### Optional but Recommended
- **fd** (for better file finding)
- **Rust toolchain** (for Rust development)
- **NASM** (for Assembly development)
- **xclip or wl-clipboard** (for clipboard support)

### Installation Commands by OS

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install neovim git ripgrep fd-find nasm build-essential cmake xclip

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Node.js (via nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 18
```

#### macOS
```bash
brew install neovim git ripgrep fd nasm

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Node.js
brew install node
```

#### Fedora
```bash
sudo dnf install neovim git ripgrep fd-find nasm
sudo dnf groupinstall "Development Tools"
sudo dnf install cmake wl-clipboard

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Node.js
sudo dnf install nodejs
```

---

## Backup Existing Configuration

**IMPORTANT**: Always backup your existing configuration before installing a new one!

### Method 1: Automated Backup Script (Recommended)

The `install.sh` script automatically creates timestamped backups. If you run it, skip to [Installation Methods](#installation-methods).

### Method 2: Manual Backup

#### Option A: Timestamped Backup
```bash
# Create timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup all Neovim directories
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.backup.$TIMESTAMP
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.backup.$TIMESTAMP
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.backup.$TIMESTAMP
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.backup.$TIMESTAMP

echo "Backup complete! Timestamp: $TIMESTAMP"
echo "To restore: mv ~/.config/nvim.backup.$TIMESTAMP ~/.config/nvim"
```

#### Option B: Simple Backup
```bash
# Quick backup with .bak extension
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak

echo "Backup complete!"
```

#### Option C: Archive Backup
```bash
# Create a tar.gz archive
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
mkdir -p ~/nvim-backups

tar -czf ~/nvim-backups/nvim-config-$TIMESTAMP.tar.gz \
  -C ~ \
  .config/nvim \
  .local/share/nvim \
  .cache/nvim \
  .local/state/nvim \
  2>/dev/null

echo "Backup archived to: ~/nvim-backups/nvim-config-$TIMESTAMP.tar.gz"

# Remove old directories
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim
```

---

## Installation Methods

### Method 1: Automated Installation (Easiest)

```bash
# Navigate to the configuration directory
cd /path/to/zero2prod/.config/nvim

# Run the installer
./install.sh
```

The script will:
1. ✓ Check all prerequisites
2. ✓ Backup your existing configuration
3. ✓ Copy files to ~/.config/nvim
4. ✓ Show post-installation instructions

### Method 2: Manual Installation

Since you already cloned the repository in the "Getting the Configuration" step, you can manually copy the files:

#### Step 1: Copy to Config Directory
```bash
# From the zero2prod directory
cp -r .config/nvim ~/.config/nvim

# Verify the copy
ls -la ~/.config/nvim
```

#### Step 2: Verify Structure
```bash
# Check that all files are present
tree ~/.config/nvim -L 2

# Should show:
# ~/.config/nvim
# ├── README.md
# ├── QUICKSTART.md
# ├── FEATURES.md
# ├── init.lua
# ├── install.sh
# ├── uninstall.sh
# └── lua
#     ├── config
#     └── plugins
```

---

## First Launch

### Launch Neovim
```bash
nvim
```

### What Happens on First Launch

1. **Plugin Manager Bootstrap** (automatic)
   - lazy.nvim will be cloned automatically
   - This takes ~5 seconds

2. **Plugin Installation** (automatic)
   - All plugins will be downloaded and installed
   - You'll see a progress window
   - This takes 2-5 minutes depending on internet speed
   - **Do not close Neovim** during this process

3. **Dashboard Appears**
   - Once installation completes, you'll see the Alpha dashboard
   - This means the installation was successful!

### Expected Output
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Lazy.nvim - Plugin Manager
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Installing gruvbox...              ✓
  Installing nvim-lspconfig...       ✓
  Installing nvim-cmp...             ✓
  Installing copilot.vim...          ✓
  ... (40+ plugins)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Post-Installation Setup

### Step 1: Install LSP Servers

After plugins install, you need LSP servers for language support.

```vim
" Open Mason (LSP installer)
:Mason
```

#### In Mason:
- Use `j/k` to navigate
- Press `i` to install a server
- Press `X` to uninstall
- Press `q` to quit

#### Auto-Install (Recommended)
The configuration is set to auto-install these servers:
- `rust-analyzer` (Rust)
- `asm-lsp` (Assembly)
- `lua-ls` (Lua)

Wait for all to show ✓ checkmarks.

#### Manual Install (Alternative)
```vim
:MasonInstall rust-analyzer asm-lsp lua-ls
```

### Step 2: Setup GitHub Copilot

If you have a Copilot subscription:

```vim
:Copilot setup
```

This will:
1. Open a browser window
2. Show a device code
3. Ask you to authenticate

Follow the on-screen instructions.

#### Verify Copilot
```vim
:Copilot status
```

Should show: "Copilot: Ready"

### Step 3: Install Additional Tools (Optional)

#### codelldb (Rust Debugger)
```vim
:MasonInstall codelldb
```

#### Additional LSP Servers
```vim
:Mason
" Browse and install any additional servers you need
```

---

## Verification

### Test 1: Create a Rust File
```bash
cd ~/test-nvim
nvim test.rs
```

In Neovim, type:
```rust
fn main() {
    println!("Hello, world!");
}
```

**Verify**:
- ✓ Syntax highlighting (colored code)
- ✓ Autocomplete appears as you type
- ✓ No error messages in status line
- ✓ LSP indicators show "rust-analyzer"

### Test 2: Test LSP Features
With cursor on `main`:
- Press `K` → Should show documentation
- Press `gd` → Should go to definition
- Type `println!` → Should show completion

### Test 3: Test Copilot (if configured)
In insert mode:
- Start typing a comment: `// Calculate`
- Wait 1-2 seconds
- Should see gray ghosted suggestion
- Press `<C-j>` to accept

### Test 4: Test Key Features
- `<Space>ff` → File finder opens
- `<Space>e` → File tree opens
- `<Space>tb` → Background toggles transparent
- `<Space>gg` → Git status (if in git repo)

### Test 5: Check Health
```vim
:checkhealth
```

Review the output. Some warnings are normal, but should be mostly green checkmarks.

---

## Troubleshooting

### Issue: Plugins Won't Install
```vim
:Lazy clean
:Lazy sync
```

### Issue: LSP Not Working
```vim
:LspInfo        " Check LSP status
:Mason          " Check installed servers
:MasonLog       " Check for errors
```

### Issue: Icons Show as Squares
- Install a Nerd Font
- Configure your terminal to use it
- Restart terminal

### Issue: Copilot Not Working
```vim
:Copilot status
:Copilot setup    " Re-authenticate
```

### Issue: Transparent Background Not Working
- Check if your terminal supports transparency
- Enable transparency in terminal settings
- Try different transparency levels

### Issue: Colors Look Wrong
```bash
# Check if terminal supports true colors
echo $TERM
# Should be: xterm-256color or similar

# In Neovim
:set termguicolors?
# Should show: termguicolors
```

### Issue: Slow Performance
```vim
:Lazy profile    " Check plugin load times
:LspInfo         " Check if too many LSP servers are running
```

### Issue: Assembly LSP Not Working
```bash
# Install asm-lsp manually
cargo install asm-lsp

# Verify
which asm-lsp

# In Neovim
:LspInfo
```

---

## Restoration

### Restore from Timestamped Backup

If you backed up with timestamps:

```bash
# List available backups
ls -ld ~/.config/nvim.backup.* 2>/dev/null

# Remove current config
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

# Restore specific backup (replace TIMESTAMP)
TIMESTAMP=20231227_123456
mv ~/.config/nvim.backup.$TIMESTAMP ~/.config/nvim
mv ~/.local/share/nvim.backup.$TIMESTAMP ~/.local/share/nvim
mv ~/.cache/nvim.backup.$TIMESTAMP ~/.cache/nvim
mv ~/.local/state/nvim.backup.$TIMESTAMP ~/.local/state/nvim

echo "Restored!"
```

### Restore Using Uninstall Script

```bash
cd ~/.config/nvim
./uninstall.sh

# Choose "restore backup" option when prompted
```

### Restore from Archive

If you used the archive method:

```bash
# List available backups
ls -lh ~/nvim-backups/

# Remove current config
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim

# Extract backup (replace TIMESTAMP)
TIMESTAMP=20231227_123456
cd ~
tar -xzf ~/nvim-backups/nvim-config-$TIMESTAMP.tar.gz

echo "Restored!"
```

---

## Additional Resources

- **Full Manual**: See `README.md` for complete documentation
- **Quick Reference**: See `QUICKSTART.md` for essential commands
- **Features List**: See `FEATURES.md` for all features

## Support

If you encounter issues:
1. Check this guide's Troubleshooting section
2. Run `:checkhealth` in Neovim
3. Check `:LspInfo` for LSP issues
4. Review `:Lazy` for plugin issues
5. Check the GitHub repository issues

---

**Installation complete! Happy coding! 🚀**
