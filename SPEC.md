# Neovim Configuration Specification

## Project Overview

Personal Neovim configuration using **lazy.nvim** as the package manager. Targets Neovim 0.12+ stable releases.

## Directory Structure

```
nvim/
├── init.lua                      # Entry point
├── lazy-lock.json                # Locked versions
├── lua/
│   ├── core/
│   │   ├── init.lua              # Main config loader
│   │   ├── settings.lua          # General vim settings
│   │   ├── lazy.lua              # lazy.nvim bootstrap
│   │   ├── keymaps.lua           # Keybindings (buffer → buf for 0.12)
│   │   ├── lint.lua              # Linting config
│   │   ├── lsp/
│   │   │   ├── init.lua          # LSP setup (new API: vim.lsp.config/enable)
│   │   │   ├── servers.lua       # Server list
│   │   │   └── configs/
│   │   │       ├── lua_ls.lua    # Lua language server
│   │   │       ├── ts_ls.lua     # TypeScript/JavaScript
│   │   │       ├── pyright.lua   # Python
│   │   │       ├── html.lua      # HTML
│   │   │       ├── cssls.lua     # CSS
│   │   │       ├── marksman.lua  # Markdown
│   │   │       └── angularls.lua # Angular
│   │   └── plugins/
│   │       ├── cmp.lua           # Completion config
│   │       └── luasnip.lua       # Snippets config
│   └── plugins/                  # Plugin specs (40+ plugins)
└── ftplugin/
    └── java.lua                  # Java filetype (codelens.enable instead of refresh)
```

## Language Servers (LSP)

Uses new Neovim 0.12+ API: `vim.lsp.config()` and `vim.lsp.enable()`.

| Server    | File                | Language             |
|-----------|---------------------|---------------------|
| lua_ls    | configs/lua_ls.lua | Lua                 |
| ts_ls     | configs/ts_ls.lua  | TypeScript/JavaScript|
| pyright   | configs/pyright.lua| Python              |
| html      | configs/html.lua   | HTML                |
| cssls     | configs/cssls.lua  | CSS                 |
| marksman  | configs/marksman.lua | Markdown         |
| angularls | configs/angularls.lua | Angular          |

## Core Plugins

### Package Manager
- **lazy.nvim** - Plugin manager (bootstrapped in `lazy.lua`)

### UI & Visuals
- **snacks** - Dashboard, picker, lazygit integration
- **noice.nvim** - UI for messages/cmdline
- **which-key.nvim** - Keybinding hints
- **incline.nvim** - Floating bufferline
- **lualine.nvim** - Statusline
- **dressing.nvim** - UI improvements
- **notify.nvim** - Notifications

### File Navigation
- **oil.nvim** - File explorer (buffer-as-filesystem)
- **tree.nvim** - File tree
- **telescope.nvim** - Fuzzy finder
- **harpoon.nvim** - Quick file access

### Code Editing
- **nvim-cmp** - Completion engine
- **luasnip** - Snippets
- **autopairs** - Auto closing pairs
- **tailwind-css** - Tailwind class completion
- **comment.nvim** - Comment toggling
- **treesitter** - Syntax highlighting

### LSP & Diagnostics
- **mason.nvim** - LSP installer UI
- **lspconfig** - LSP client config (uses new `vim.lsp.config/enable` API)
- **nvim-lint** - Inline linting
- **trouble.nvim** - LSP diagnostics list

### Git
- **gitsigns.nvim** - Git signs in gutter
- **fugitive.nvim** - Git wrapper

### Debugging
- **nvim-dap** - Debug adapter protocol

### Notes & Tasks
- **obsidian.nvim** - Obsidian integration
- **todo-comments.nvim** - TODO/FIXME tracking
- **render-markdown.nvim** - Markdown preview

### Other
- **copilot.lua** - AI completion
- **jdtls.nvim** - Java LSP
- **undotree.nvim** - Undo history
- **terminal.nvim** - Terminal toggling

## Keymaps

### Leader: `<Space>`

Keymaps are organized into groups managed by which-key.nvim. See `lua/plugins/whichkey.lua` for the full spec.

| Prefix   | Group                |
|----------|----------------------|
| `<leader>b` | Buffers             |
| `<leader>C` | Comment             |
| `<leader>c` | Code                |
| `<leader>e` | Explorer            |
| `<leader>f` | Files               |
| `<leader>g` | Git                 |
| `<leader>n` | Notes               |
| `<leader>p` | Pickers             |
| `<leader>t` | Terminal            |
| `<leader>u` | UI                  |
| `<leader>w` | Windows             |
| `<leader>d` | Debug               |
| `<leader>D` | DataBase            |
| `<leader>T` | Trouble             |

### LSP Keymaps (Buffer-local)

Note: Uses `buf` instead of deprecated `buffer` option (Neovim 0.12+).

| Key          | Action                    |
|--------------|---------------------------|
| `K`          | Hover documentation       |
| `<leader>cd` | Go to definition         |
| `<leader>cD` | Go to declaration        |
| `<leader>ci` | Go to implementation     |
| `<leader>cr` | Find references          |
| `<leader>cR` | Rename symbol            |
| `<leader>ca` | Code actions            |
| `<leader>cf` | Format code            |

### Window Navigation

| Key          | Action              |
|--------------|---------------------|
| `<leader>wh` | Move left           |
| `<leader>wj` | Move down           |
| `<leader>wk` | Move up             |
| `<leader>wl` | Move right          |
| `<leader>wv` | Vertical split     |
| `<leader>wH` | Horizontal split  |

### Terminal Mode

| Key   | Action              |
|-------|--------------------|
| `<esc>` | Exit terminal mode |

## Settings

### General
- Leader: `Space`
- Numbering: relative numbers enabled
- Tab: 2 spaces, expand to spaces
- Swap files: disabled
- Undo file: enabled
- Clipboard: unnamedplus (system clipboard)

### Search
- Case insensitive, smart case
- Incremental search with command preview

### UI
- Dark background
- Sign column: enabled
- Cursor line: highlighted
- Conceal level: 2

## Dependencies

### System Requirements
- Neovim 0.11+ (stable)
- Git (for lazy.nvim and plugin updates)
- ripgrep (for grep functionality)
- SQLite (for some plugins)
- Node.js (for LSP functionality)
- Python3 (for some plugins)
- LazyGit (for Snacks lazygit integration)

### Neovim 0.12 Changes Addressed

| Deprecated API | Replacement | File |
|---------------|-------------|------|
| `buffer` in keymap opts | `buf` | `lua/core/keymaps.lua`, `lua/plugins/obsidian.lua` |
| `vim.lsp.codelens.refresh()` | `vim.lsp.codelens.enable(true)` | `ftplugin/java.lua` |
| Old LSP setup (`lspconfig.setup()`) | `vim.lsp.config()` + `vim.lsp.enable()` | `lua/core/lsp/init.lua` |

## Automation

- **lazy.nvim** handles:
  - Plugin installation/update
  - Plugin check for updates (enabled, notify disabled)
  - Change detection for config changes
