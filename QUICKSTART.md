# Quick Start Guide

Welcome to your new Neovim configuration for Rust and Assembly x86_64 development!

## Getting the Configuration

First, download the configuration from the repository:

```bash
# Clone the repository
git clone https://github.com/paolocampomail-cloud/zero2prod.git
cd zero2prod
```

## Installation (3 Simple Steps)

### 1. Run the installer
```bash
cd .config/nvim
./install.sh
```

The installer will:
- ✓ Check prerequisites
- ✓ Backup your existing config
- ✓ Install the new configuration

### 2. Launch Neovim
```bash
nvim
```

On first launch, plugins will install automatically (2-5 minutes).

### 3. Setup Copilot (Optional)
```vim
:Copilot setup
```

## Essential Keybindings

**Leader key**: `Space`

| Action | Keybind |
|--------|---------|
| Find files | `<Space>ff` |
| Find in files | `<Space>fg` |
| File explorer | `<Space>e` |
| Toggle transparent | `<Space>tb` |
| Save file | `Ctrl+s` |
| Copilot Chat | `<Space>cc` |
| Accept Copilot | `Ctrl+j` (insert) |

## Quick Test

Create a Rust file to test:
```bash
nvim test.rs
```

Type this code and watch autocomplete work:
```rust
fn main() {
    println!("Hello, world!");
}
```

## Need Help?

- Full documentation: `README.md`
- Check health: `:checkhealth`
- LSP status: `:LspInfo`
- Plugin manager: `:Lazy`

## Uninstall

To remove and restore backup:
```bash
./uninstall.sh
```

---

**Happy coding! 🚀**
