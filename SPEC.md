# Neovim Configuration Specification

## Project Overview

Personal Neovim configuration using **lazy.nvim** as the package manager. Targets Neovim 0.9+ stable releases.

## Directory Structure

```
nvim/
├── init.lua                      # Entry point
├── lazy-lock.json                # Locked versions
├── lua/
│   ├── config/
│   │   ├── init.lua              # Main config loader
│   │   ├── settings.lua          # General vim settings
│   │   ├── lazy.lua              # lazy.nvim bootstrap
│   │   ├── keymaps.lua           # Keybindings
│   │   ├── lint.lua              # Linting config
│   │   ├── lsp/
│   │   │   ├── init.lua          # LSP setup
│   │   │   ├── lua_ls.lua        # Lua language server
│   │   │   ├── ts_ls.lua         # TypeScript/JavaScript
│   │   │   ├── pyright.lua       # Python
│   │   │   ├── html.lua          # HTML
│   │   │   ├── cssls.lua         # CSS
│   │   │   ├── marksman.lua      # Markdown
│   │   │   └── angularls.lua     # Angular
│   │   └── plugins/
│   │       ├── cmp.lua           # Completion config
│   │       └── luasnip.lua       # Snippets config
│   └── plugins/                  # Plugin specs (40+ plugins)
└── ftplugin/
    ├── java.lua                  # Java filetype
    └── lua.lua                   # Lua filetype
```

## Language Servers (LSP)

| Server    | File           | Language             |
|-----------|----------------|---------------------|
| lua_ls    | lua_ls.lua    | Lua                 |
| ts_ls     | ts_ls.lua     | TypeScript/JavaScript|
| pyright   | pyright.lua   | Python              |
| html      | html.lua      | HTML                |
| cssls     | cssls.lua     | CSS                 |
| marksman  | marksman.lua | Markdown           |
| angularls | angularls.lua| Angular            |

## Core Plugins

### Package Manager
- **lazy.nvim** - Plugin manager (bootstrapped in `lazy.lua`)

### UI & Visuals
- **snaks** - Dashboard, picker, lazygit integration
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
- **lspconfig** - LSP client config
- **null-ls** - Diagnostic tools
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

| Prefix   | Action                | Description              |
|----------|----------------------|--------------------------|
| `<leader>w` | Save/Close            | Vim operations           |
| `<leader>b` | Buffers               | Buffer navigation       |
| `<leader>u` | UI                    | UI toggles              |
| `<leader>p` | Picker                | Telescope/Snacks picker |
| `<leader>e` | Explorer              | File explorer (Oil)     |
| `<leader>t` | Terminal              | Terminal toggles         |
| `<leader>n` | Notes                 | Obsidian/Todo notes     |
| `<leader>g` | Git                   | Git operations         |
| `<leader>c` | Code                  | LSP code actions       |

### LSP Keymaps (Buffer-local)

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
- Neovim 0.9+ (stable)
- Git (for lazy.nvim and plugin updates)
- ripgrep (for grep functionality)
- SQLite (for some plugins)

## Automation

- **lazy.nvim** handles:
  - Plugin installation/update
  - Plugin check for updates (enabled, notify disabled)
  - Change detection for config changes
