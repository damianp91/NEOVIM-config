# Neovim Configuration

A personal and optimized Neovim setup for a smooth and efficient development experience. This configuration is tailored for performance, featuring plugins for better code navigation, completion, and customization.

![Neovim config](photos/nvim.png)

## 🚀 Features
- **Lazy-loaded plugins** for better performance
  ![Lazy plugins](photos/lazy.png)
- **Tree-sitter** for improved syntax highlighting
  ![Tree-sitter](photos/tree-sitter.png)
- **LSP and DAP** support for a full coding experience
  ![Debugger](photos/debugger.png)
- **Telescope** for fuzzy file searching
  ![Telescope](photos/telescopenot.png)
- **Git integration** with gitsigns and fugitive
  ![Git signs](photos/git-signs.png)
- **Custom key mappings** for efficiency
  ![Key mappings](photos/key-mapping.png)
- **Terminal.nvim** for an integrated terminal
  ![Terminal](photos/terminal.png)
- **OpenCode** integrated (you should download OpenCode on your computer)
  ![OpenCode](photos/opencode.png)

## 📥 Installation
Clone this repository and place the configuration files in your Neovim directory:

```sh
git clone https://github.com/damianp91/NEOVIM-config ~/.config/nvim
```

Ensure you have Neovim 0.11+ (stable) installed.

### Dependencies
- Neovim 0.11+ (stable)
- Git
- Node.js (for LSP functionality)
- Python3 (for some plugins)
- Ripgrep (for Telescope)
- LazyGit (for Snacks lazygit integration)

## 🛠️ Setup
After cloning, open Neovim and run:

```sh
nvim
```

The plugins will automatically install on the first run.

## 🎯 Keybindings

This configuration organizes keymaps into **groups** managed by [which-key.nvim](https://github.com/folke/which-key.nvim). You can see all available groups in `lua/plugins/whichkey.lua`:

| Prefix   | Group      |
|----------|------------|
| `<leader>b` | Buffers  |
| `<leader>C` | Comment  |
| `<leader>c` | Code     |
| `<leader>e` | Explorer |
| `<leader>f` | Files    |
| `<leader>g` | Git      |
| `<leader>n` | Notes    |
| `<leader>p` | Pickers  |
| `<leader>t` | Terminal |
| `<leader>u` | UI       |
| `<leader>w` | Windows  |
| `<leader>d` | Debug    |
| `<leader>D` | DataBase |
| `<leader>T` | Trouble  |

Some useful shortcuts:
- `<leader>ef` → Find files with Snacks picker
- `<leader>pg` → Grep in files
- `<leader>gs` → Git status
- `<leader>r` → Reload current buffer
- `<leader>tf`, `<leader>tv`, `<leader>th` → Open terminal
- `<leader>uo` → Open OpenCode panel

## 📜 License
This configuration is open-source and available under the MIT License.
---

> [!NOTE]
> If you need more information about the specifications of this
> configuration, you can see  [spec.md](/SPEC.md)
