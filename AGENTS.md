# AGENTS.md

## Project Overview

A modular Neovim configuration built on lazy.nvim, with flexible switching between multiple optional implementations.

## Core File Guide

### lua/core/

- `init.lua`: Entry point for loading core modules. Loads `options`, `keymaps`, `autocmds`, `filetype`, `neovide`, and `custom` in order.
- `options.lua`: Base editor option configuration, including UI display, line numbers, indentation, editing experience, search, and completion.
- `keymaps.lua`: Global key mappings, including basic editing, window management, LSP actions, and quick file access.
- `config.lua`: User configuration center. Defines selectable options for themes, search tools, completion engines, autocommands, and more.
- `autocmds.lua`: Autocommand configuration, including autosave, cursor restore, yank highlighting, and automatic window resizing.
- `filetype.lua`: Filetype-related configuration.
- `neovide.lua`: Configuration specific to the Neovide GUI client.
- `custom.lua`: Extension point for user custom configuration.

### lua/plugins/

- `init.lua`: Plugin manager initialization and lazy.nvim setup.
- `ai.lua`: AI-related tools, including GitHub Copilot integration.
- `cmp.lua`: Completion engine configuration, supporting both `cmp` and `blink`.
- `colorscheme.lua`: Theme configuration, supporting `tokyonight`, `evergarden`, and `catppuccin`.
- `dashboard.lua`: Startup screen configuration.
- `find.lua`: Search tool configuration, supporting both `telescope` and `fzf-lua`.
- `indent.lua`: Indentation visualization plugin configuration.
- `lang.lua`: Language-specific plugin configuration.
- `lsp.lua`: LSP configuration, including `mason`, `lspconfig`, and `conform` formatting tools.
- `move.lua`: Cursor movement enhancement plugins.
- `quickfix.lua`: Quickfix list enhancements.
- `snippets.lua`: Snippet configuration.
- `tools.lua`: Utility plugins, including `wakatime`, session management, `yanky`, `surround`, `dial`, `neogen`, `ufo`, and `codesnap`.
- `treesitter.lua`: Treesitter parsers and related plugins such as `autotag`, `autopairs`, and `comment`.
- `ui.lua`: UI enhancement plugins, including `gitsigns`, `lualine`, `grug-far`, `toggleterm`, `aerial`, and `yazi`.

### init.lua

Main entry file. Loads the `core` and `plugins` modules.

## Common Operations

> [!IMPORTANT]
> Before performing any operation such as adding plugins or modifying configuration, you must check the plugin's official documentation instead of guessing. You may use any web search tools for this, such as jina or Google.

### Add a New Plugin

1. Choose or create the appropriate category file under `lua/plugins/`.
2. Define the plugin configuration following lazy.nvim conventions:
   ```lua
   local plugin_name = {
     "author/plugin-name",
     event = "VeryLazy",
     opts = {},
   }
   ```
3. Add the plugin to the `return` statement at the end of the file.

### Modify Plugin Configuration

1. Find the file that contains the target plugin, usually under `lua/plugins/`.
2. Modify the plugin's `opts` table or `config` function.

### Add Key Mappings

If the key mapping is specific to a plugin, usually add it in the plugin's configuration file using the `keys` field so it can participate in lazy loading.

If it is a global key mapping, follow this process:

1. Open `lua/core/keymaps.lua`.
2. Add a new mapping with the `map` function:
   ```lua
   map("n", "<leader>xx", "<cmd>YourCommand<cr>", { desc = "Description" })
   ```
3. Parameters: mode (`n`/`i`/`v`/etc.), key, command, and options (`desc` is used by which-key for display).

### Adjust LSP Configuration

#### Add a New LSP Server

1. Open `lua/plugins/lsp.lua`.
2. Add the server name to `mason_lspconfig.opts.ensure_installed`.
3. If special configuration is needed, add it in `lspconfig.config`:
   ```lua
   vim.lsp.config("server_name", {
     settings = {},
   })
   ```

#### Add a Formatter

1. Add the formatter under `conform.opts.formatters_by_ft` in `lua/plugins/lsp.lua`:
   ```lua
   filetype = { "formatter_name" },
   ```
2. If you need a custom formatter, define it under `conform.opts.formatters`.

### Switch Theme / Search Engine / Completion Engine

1. Open `lua/core/config.lua`.
2. Modify the relevant configuration fields:
   - `M.colorscheme`: switch theme (`tokyonight` / `evergarden` / `catppuccin`)
   - `M.find`: switch search tool (`telescope` / `fzf-lua`)
   - `M.cmp`: switch completion engine (`cmp` / `blink`)
   - `M.lsp_tools`: switch LSP tool integration (`fzf` / `trouble` / `telescope` / `native`)
   - `M.indent`: switch indentation visualization (`hlchunk` / `indent-blankline` / `snack` / `indentmini`)
   - `M.dashboard`: switch startup screen (`dashboard` / `snack`)
