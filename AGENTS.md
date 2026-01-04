# AGENTS.md

## 项目概述

基于 lazy.nvim 的模块化 Neovim 配置，支持多种可选方案的灵活切换。

## 核心文件说明

### lua/core/

- **init.lua**: 核心模块加载入口，按顺序加载 options、keymaps、autocmds、filetype、neovide、custom 模块
- **options.lua**: 编辑器基础选项配置，包括 UI 显示、行号缩进、编辑体验、搜索补全等设置
- **keymaps.lua**: 全局键位映射配置，包括基础编辑、窗口管理、LSP 操作、快速文件打开等
- **config.lua**: 用户配置中心，定义主题、搜索工具、补全引擎、自动命令等可选方案
- **autocmds.lua**: 自动命令配置，包括自动保存、恢复光标位置、高亮复制、自动调整窗口等
- **filetype.lua**: 文件类型相关配置
- **neovide.lua**: Neovide GUI 客户端专用配置
- **custom.lua**: 用户自定义配置扩展点

### lua/plugins/

- **init.lua**: 插件管理器初始化，配置 lazy.nvim
- **ai.lua**: AI 辅助工具，包括 GitHub Copilot 集成
- **cmp.lua**: 补全引擎配置，支持 cmp 和 blink 两种引擎
- **colorscheme.lua**: 主题配置，支持 tokyonight、evergarden、catppuccin
- **dashboard.lua**: 启动界面配置
- **find.lua**: 搜索工具配置，支持 telescope 和 fzf-lua 两种引擎
- **indent.lua**: 缩进显示插件配置
- **lang.lua**: 语言特定插件配置
- **lsp.lua**: LSP 配置，包括 mason、lspconfig、conform 格式化工具
- **move.lua**: 光标移动增强插件
- **quickfix.lua**: 快速修复列表增强
- **snippets.lua**: 代码片段配置
- **tools.lua**: 工具类插件，包括 wakatime、会话管理、yanky、surround、dial、neogen、ufo、codesnap
- **treesitter.lua**: Treesitter 语法解析器及相关插件（autotag、autopairs、comment）
- **ui.lua**: UI 增强插件，包括 gitsigns、lualine、grug-far、toggleterm、aerial、yazi

### init.lua

主入口文件，加载 core 和 plugins 模块。

## 常见操作

> [!IMPORTANT]
> 注意你在进行任何操作（添加插件、修改配置）时必须要查看他的官网文档，避免臆测，为此你可以使用任何网络搜索工具，如 jina、Google 等


### 添加新插件

1. 在 `lua/plugins/` 目录下选择或创建对应分类的文件
2. 按照 lazy.nvim 规范定义插件配置：
   ```lua
   local plugin_name = {
     "author/plugin-name",
     event = "VeryLazy",  -- 或其他加载时机
     opts = {},           -- 插件选项
   }
   ```
3. 在文件末尾的 return 语句中添加该插件

### 修改插件配置

1. 找到对应插件所在的文件（通常在 `lua/plugins/` 目录下）
2. 修改插件的 `opts` 表或 `config` 函数

### 添加键位映射

如果是插件独有的键位映射，通常在对应插件的配置文件中添加 `keys` 字段，以实现懒加载

如果是全局键位映射，你可以按照下面这个流程

1. 打开 `lua/core/keymaps.lua`
2. 使用 `map` 函数添加新映射：
   ```lua
   map("n", "<leader>xx", "<cmd>YourCommand<cr>", { desc = "Description" })
   ```
3. 参数说明：模式（n/i/v/等）、按键、命令、选项（desc 用于 which-key 显示）

### 调整 LSP 配置

#### 添加新的 LSP 服务器

1. 打开 `lua/plugins/lsp.lua`
2. 在 `mason_lspconfig.opts.ensure_installed` 中添加服务器名称
3. 如需特殊配置，在 `lspconfig.config` 函数中添加：
   ```lua
   vim.lsp.config("server_name", {
     settings = {},
   })
   ```

#### 添加格式化工具

1. 在 `lua/plugins/lsp.lua` 的 `conform.opts.formatters_by_ft` 中添加：
   ```lua
   filetype = { "formatter_name" },
   ```
2. 如需自定义格式化器，在 `conform.opts.formatters` 中定义

### 切换主题/搜索引擎/补全引擎

1. 打开 `lua/core/config.lua`
2. 修改对应配置项：
   - `M.colorscheme`: 切换主题（tokyonight/evergarden/catppuccin）
   - `M.find`: 切换搜索工具（telescope/fzf-lua）
   - `M.cmp`: 切换补全引擎（cmp/blink）
   - `M.lsp_tools`: 切换 LSP 工具（fzf/trouble/telescope/native）
   - `M.indent`: 切换缩进显示（hlchunk/indent-blankline/snack/indentmini）
   - `M.dashboard`: 切换启动界面（dashboard/snack）
