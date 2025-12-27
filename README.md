# Neovim Configuration for Rust & Assembly x86_64 Development

A comprehensive, enterprise-level Neovim configuration optimized for Rust and Assembly (x86_64 NASM) development with full GitHub Copilot integration and an old-school dark theme.

## Features

### 🎨 Theme & Appearance
- **Gruvbox Dark Theme**: Classic, old-school vibe with excellent readability
- **Transparent Background Toggle**: Switch between solid and glossy transparent backgrounds with `<leader>tb`
- Beautiful statusline (lualine) and bufferline
- Smooth startup screen with ASCII art
- Indent guides and colorizer for better code visualization

### 🦀 Rust Development
- **rust-analyzer**: Full-featured Rust LSP with:
  - Intelligent code completion
  - Inline error diagnostics
  - Type hints and inlay hints
  - Code actions and refactoring
  - Clippy integration
  - Cargo.toml dependency management with crates.nvim
- **Rust Tools**: Enhanced Rust development with hover actions and debugging
- **DAP Integration**: Full debugging support with codelldb

### ⚙️ Assembly x86_64 (NASM) Support
- **asm-lsp**: Assembly language server for NASM
- Syntax highlighting via Treesitter
- Dedicated keybinds for assembly workflow:
  - `<leader>aa`: Assemble with NASM
  - `<leader>al`: Link with ld
  - `<leader>ar`: Run executable

### 🤖 GitHub Copilot (Full AI Integration)
- **Copilot.vim**: AI-powered code completion
- **CopilotChat**: Interactive AI assistant with:
  - Code explanations (general, Rust-specific, Assembly-specific)
  - Code review and optimization
  - Test generation
  - Documentation generation
  - Bug fixing
- **Model Selection**: Easy switching between AI models:
  - GPT-4
  - GPT-4 Turbo
  - GPT-3.5 Turbo
  - Claude 3 Opus
  - Claude 3 Sonnet
  - Use `<leader>cm` to select model

### 📦 Enterprise-Level Plugin Collection
- **Fuzzy Finder**: Telescope for fast file navigation
- **File Explorer**: NvimTree with git integration
- **Git Integration**: Fugitive and Gitsigns for version control
- **Terminal**: ToggleTerm with floating window support
- **Completion**: nvim-cmp with multiple sources
- **Treesitter**: Advanced syntax highlighting
- **Diagnostics**: Trouble for better error viewing
- **Auto-pairs**: Smart bracket pairing
- **Surround**: Easy text surrounding operations
- **Comments**: Quick commenting with Comment.nvim
- **Todo Comments**: Highlight TODO, FIXME, etc.
- **Session Management**: Automatic session saving
- **Which-key**: Discover keybindings as you type

### ⚡ Performance
- Lazy loading for fast startup
- Optimized plugin configuration
- Disabled unnecessary built-in plugins

## Keybindings

### General
- **Leader Key**: `<Space>`
- `<C-h/j/k/l>`: Navigate between windows
- `<S-h/l>`: Previous/Next buffer
- `<leader>bd`: Close buffer
- `<C-s>`: Save file
- `<leader>q`: Quit
- `<Esc>`: Clear search highlights

### File Navigation (Telescope)
- `<leader>ff`: Find files
- `<leader>fg`: Live grep (search in files)
- `<leader>fb`: Browse buffers
- `<leader>fr`: Recent files
- `<leader>fh`: Help tags
- `<leader>fs`: Grep string under cursor

### File Explorer (NvimTree)
- `<leader>e`: Toggle file explorer
- `<leader>o`: Focus file explorer

### LSP & Diagnostics
- `gd`: Go to definition
- `gr`: Find references
- `K`: Hover documentation
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `<leader>f`: Format code
- `[d` / `]d`: Previous/Next diagnostic
- `<leader>d`: Show diagnostic float

### Rust Specific
- `<leader>rr`: Rust runnables
- `<leader>rd`: Rust debuggables
- `<leader>rt`: Cargo test
- `<leader>rc`: Cargo check
- `<leader>rb`: Cargo build
- `<leader>ru`: Cargo update

### Assembly Specific
- `<leader>aa`: Assemble with NASM (produces .o file)
- `<leader>al`: Link with ld (produces executable)
- `<leader>ar`: Run the executable

### GitHub Copilot
- `<C-j>` (insert mode): Accept Copilot suggestion
- `<C-n>` (insert mode): Next suggestion
- `<C-p>` (insert mode): Previous suggestion
- `<leader>cc`: Open Copilot Chat
- `<leader>ce`: Explain code
- `<leader>cr`: Review code
- `<leader>cf`: Fix code
- `<leader>co`: Optimize code
- `<leader>cd`: Generate documentation
- `<leader>ct`: Generate tests
- `<leader>cm`: Select Copilot model

### Terminal
- `<leader>tt`: Toggle terminal
- `<C-\>`: Toggle terminal (alternative)
- `<Esc>` (in terminal): Exit terminal mode

### Git
- `<leader>gg`: Git status
- `<leader>gp`: Git push
- `<leader>gP`: Git pull
- `<leader>gb`: Git blame
- `<leader>gd`: Git diff
- `<leader>gh`: Preview hunk

### Theme
- `<leader>tb`: Toggle transparent background (solid ↔ glossy transparent)

### Debugging (DAP)
- `<F5>`: Continue
- `<F10>`: Step over
- `<F11>`: Step into
- `<F12>`: Step out
- `<leader>db`: Toggle breakpoint
- `<leader>du`: Toggle debug UI

### Trouble (Diagnostics)
- `<leader>xx`: Toggle Trouble
- `<leader>xw`: Workspace diagnostics
- `<leader>xd`: Document diagnostics

### Comments
- `<leader>/`: Toggle line comment (normal and visual mode)
- `gcc`: Toggle line comment
- `gbc`: Toggle block comment

## Prerequisites

Before installing this configuration, ensure you have the following installed:

### Required
1. **Neovim >= 0.9.0**
   ```bash
   # Check version
   nvim --version
   ```

2. **Git**
   ```bash
   git --version
   ```

3. **A Nerd Font** (for icons)
   - Download from: https://www.nerdfonts.com/
   - Recommended: JetBrainsMono Nerd Font, FiraCode Nerd Font, or Hack Nerd Font
   - Configure your terminal to use the Nerd Font

4. **ripgrep** (for Telescope live grep)
   ```bash
   # Ubuntu/Debian
   sudo apt install ripgrep
   
   # macOS
   brew install ripgrep
   
   # Fedora
   sudo dnf install ripgrep
   ```

5. **fd** (optional, for better file finding)
   ```bash
   # Ubuntu/Debian
   sudo apt install fd-find
   
   # macOS
   brew install fd
   
   # Fedora
   sudo dnf install fd-find
   ```

### Rust Development Tools
1. **Rust toolchain**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **rust-analyzer** (will be installed by Mason automatically)

3. **codelldb** (for debugging, optional)
   ```bash
   # Will be prompted to install when needed
   ```

### Assembly Development Tools
1. **NASM** (Netwide Assembler)
   ```bash
   # Ubuntu/Debian
   sudo apt install nasm
   
   # macOS
   brew install nasm
   
   # Fedora
   sudo dnf install nasm
   ```

2. **asm-lsp** (will be installed by Mason automatically)
   ```bash
   # Or install manually:
   cargo install asm-lsp
   ```

### GitHub Copilot
1. **GitHub Copilot subscription**
   - Sign up at: https://github.com/features/copilot
   - You'll need to authenticate Copilot on first use

2. **Node.js >= 16** (for Copilot)
   ```bash
   # Check version
   node --version
   ```

### Build Tools
```bash
# Ubuntu/Debian
sudo apt install build-essential cmake

# macOS (Xcode Command Line Tools)
xcode-select --install

# Fedora
sudo dnf groupinstall "Development Tools"
sudo dnf install cmake
```

## Installation

### Step 0: Get the Configuration

First, download the Neovim configuration from the repository:

```bash
# Clone the repository
git clone https://github.com/paolocampomail-cloud/zero2prod.git
cd zero2prod
```

Now you have the configuration files in `zero2prod/.config/nvim/`.

### Step 1: Backup Your Existing Neovim Configuration

If you have an existing Neovim configuration, it's important to back it up before installing this new configuration.

#### Option A: Create a timestamped backup (Recommended)
```bash
# Get current timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Backup Neovim config directory
if [ -d ~/.config/nvim ]; then
    mv ~/.config/nvim ~/.config/nvim.backup.$TIMESTAMP
    echo "✓ Backed up ~/.config/nvim to ~/.config/nvim.backup.$TIMESTAMP"
fi

# Backup Neovim data directory (plugins, cache, etc.)
if [ -d ~/.local/share/nvim ]; then
    mv ~/.local/share/nvim ~/.local/share/nvim.backup.$TIMESTAMP
    echo "✓ Backed up ~/.local/share/nvim to ~/.local/share/nvim.backup.$TIMESTAMP"
fi

# Backup Neovim cache directory
if [ -d ~/.cache/nvim ]; then
    mv ~/.cache/nvim ~/.cache/nvim.backup.$TIMESTAMP
    echo "✓ Backed up ~/.cache/nvim to ~/.cache/nvim.backup.$TIMESTAMP"
fi

# Backup Neovim state directory (sessions, undo, etc.)
if [ -d ~/.local/state/nvim ]; then
    mv ~/.local/state/nvim ~/.local/state/nvim.backup.$TIMESTAMP
    echo "✓ Backed up ~/.local/state/nvim to ~/.local/state/nvim.backup.$TIMESTAMP"
fi

echo ""
echo "✓ Backup complete! Your old configuration is safely stored."
echo "  You can restore it later by running:"
echo "  mv ~/.config/nvim.backup.$TIMESTAMP ~/.config/nvim"
```

#### Option B: Simple backup with .bak extension
```bash
# Backup config directory
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -d ~/.local/share/nvim ] && mv ~/.local/share/nvim ~/.local/share/nvim.bak
[ -d ~/.cache/nvim ] && mv ~/.cache/nvim ~/.cache/nvim.bak
[ -d ~/.local/state/nvim ] && mv ~/.local/state/nvim ~/.local/state/nvim.bak

echo "✓ Backup complete! Restore with: mv ~/.config/nvim.bak ~/.config/nvim"
```

### Step 2: Install This Configuration

Now that you have the repository cloned (from Step 0), choose one of these installation methods:

#### Method 1: Automated Installation (Recommended)
```bash
# From the zero2prod directory
cd .config/nvim
./install.sh
```

The installer will automatically:
- Check prerequisites
- Backup your existing configuration
- Install the new configuration
- Show next steps

#### Method 2: Manual Installation
```bash
# Copy the configuration to your Neovim config directory
cp -r .config/nvim ~/.config/nvim

echo "✓ Configuration files copied successfully!"
```

### Step 3: First Launch

Launch Neovim for the first time. This will automatically:
1. Install the lazy.nvim plugin manager
2. Download and install all plugins
3. Set up LSP servers via Mason

```bash
nvim
```

**What to expect:**
- On first launch, you'll see lazy.nvim installing plugins (this may take 2-5 minutes)
- The screen might look busy with installation messages - this is normal!
- Once installation completes, you'll see the dashboard
- Some features may not work until LSP servers are installed (next step)

### Step 4: Install LSP Servers

After the initial plugin installation, install the language servers:

1. Open Mason (the LSP installer):
   ```vim
   :Mason
   ```

2. The following servers should install automatically:
   - `rust-analyzer` (Rust)
   - `asm-lsp` (Assembly)
   - `lua-ls` (Lua)

3. If they don't install automatically, you can install them manually:
   - Press `i` on each server to install
   - Or run: `:MasonInstall rust-analyzer asm-lsp lua_ls`

4. Wait for all installations to complete (you'll see checkmarks)

5. Close Mason: Press `q`

### Step 5: Set Up GitHub Copilot

1. Start Copilot setup:
   ```vim
   :Copilot setup
   ```

2. Follow the authentication process:
   - A browser window will open
   - Log in to your GitHub account
   - Enter the device code shown in Neovim
   - Authorize GitHub Copilot

3. Verify Copilot is working:
   ```vim
   :Copilot status
   ```

### Step 6: Verify Installation

Create a test Rust file to verify everything works:

```bash
# Create a test file
mkdir -p ~/nvim-test
cd ~/nvim-test
nvim test.rs
```

In the file, type:
```rust
fn main() {
    println!("Hello, world!");
}
```

**Verify these features:**
- ✓ Syntax highlighting (colors)
- ✓ Autocomplete appears as you type
- ✓ Copilot suggestions appear (ghosted text)
- ✓ No errors in the status line
- ✓ LSP info shows at bottom (rust-analyzer)

Test the transparent background toggle:
- Press `<Space>` then `t` then `b`
- Background should become transparent

### Step 7: Optional Post-Installation

#### Install Additional Tools

1. **Clipboard support** (for system clipboard integration):
   ```bash
   # Ubuntu/Debian
   sudo apt install xclip wl-clipboard
   
   # macOS (already included)
   
   # Fedora
   sudo dnf install xclip wl-clipboard
   ```

2. **Debugging tools** (for DAP):
   ```bash
   # codelldb for Rust debugging
   # Install via Mason:
   # :MasonInstall codelldb
   ```

3. **Better grep** (for faster searches):
   ```bash
   # Already installed ripgrep in prerequisites
   ```

#### Customize Configuration

The configuration is modular and easy to customize:

- **Main config**: `~/.config/nvim/init.lua`
- **Options**: `~/.config/nvim/lua/config/options.lua`
- **Keymaps**: `~/.config/nvim/lua/config/keymaps.lua`
- **Plugins**: `~/.config/nvim/lua/plugins/*.lua`

#### Update Plugins

To update all plugins to their latest versions:
```vim
:Lazy sync
```

## Restoring Your Old Configuration

If you want to restore your old Neovim configuration:

```bash
# Remove the new configuration
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

# Restore your backup (adjust the timestamp)
TIMESTAMP=20231227_123456  # Use your actual timestamp
mv ~/.config/nvim.backup.$TIMESTAMP ~/.config/nvim
mv ~/.local/share/nvim.backup.$TIMESTAMP ~/.local/share/nvim
mv ~/.cache/nvim.backup.$TIMESTAMP ~/.cache/nvim
mv ~/.local/state/nvim.backup.$TIMESTAMP ~/.local/state/nvim

echo "✓ Old configuration restored!"
```

Or if you used the simple backup:
```bash
rm -rf ~/.config/nvim && mv ~/.config/nvim.bak ~/.config/nvim
rm -rf ~/.local/share/nvim && mv ~/.local/share/nvim.bak ~/.local/share/nvim
rm -rf ~/.cache/nvim && mv ~/.cache/nvim.bak ~/.cache/nvim
rm -rf ~/.local/state/nvim && mv ~/.local/state/nvim.bak ~/.local/state/nvim
```

## Troubleshooting

### Plugins won't install
```vim
:Lazy clean
:Lazy sync
```

### LSP not working
```vim
:LspInfo          " Check LSP status
:Mason            " Check installed servers
:MasonLog         " Check for errors
```

### Copilot not working
```vim
:Copilot status   " Check authentication
:Copilot setup    " Re-authenticate
```

### Icons not showing
- Make sure you installed a Nerd Font
- Configure your terminal to use the Nerd Font
- Restart your terminal

### Transparent background not working
- Ensure your terminal supports transparency
- Check terminal settings for transparency/opacity

### Assembly LSP not working
```bash
# Install asm-lsp manually
cargo install asm-lsp

# Verify installation
which asm-lsp
```

### Performance issues
```vim
:checkhealth      " Run Neovim health check
```

## Uninstallation

To completely remove this configuration:

```bash
# Remove all Neovim directories
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.local/state/nvim

echo "✓ Neovim configuration removed!"
```

## Quick Reference Card

Print or keep this handy:

```
Leader: <Space>

FILES                  LSP                    GIT
<leader>ff  Find       gd  Definition         <leader>gg  Status
<leader>fg  Grep       gr  References         <leader>gp  Push
<leader>e   Explorer   K   Hover              <leader>gb  Blame
<leader>fb  Buffers    <leader>rn  Rename     <leader>gd  Diff

RUST                   COPILOT                ASSEMBLY
<leader>rc  Check      <C-j>  Accept          <leader>aa  Assemble
<leader>rb  Build      <leader>cc  Chat       <leader>al  Link
<leader>rt  Test       <leader>cm  Models     <leader>ar  Run

THEME                  DEBUG
<leader>tb  Toggle     F5   Continue
            Transparent F10  Step Over
                       <leader>db  Breakpoint
```

## Credits

This configuration uses these excellent plugins:
- lazy.nvim - Plugin manager
- gruvbox - Color scheme
- rust-analyzer - Rust LSP
- asm-lsp - Assembly LSP
- GitHub Copilot - AI assistance
- Telescope - Fuzzy finder
- And many more...

## License

This configuration is provided as-is for the zero2prod project.

## Support

For issues or questions about this configuration:
1. Check the troubleshooting section
2. Run `:checkhealth` in Neovim
3. Check plugin documentation: `:Lazy`
4. Open an issue in the repository

---

**Happy Coding! 🚀**
