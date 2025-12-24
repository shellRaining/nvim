# ShellRaining's Neovim Configuration

一个快速、现代化的 Neovim 配置，专注于提供流畅的开发体验。

## 运行需求

### 必需组件

- Neovim >= 0.9.0
- Git
- 一个 Nerd Font 字体
- Node.js >= 24 (用于 LSP 和 copilot 支持)
- gcc/clang (用于编译某些插件)
- ripgrep (用于全文搜索)
- lazygit (用于 Git 集成)
- fd (用于文件查找)

### 可选组件

- Python3 (用于某些插件)
- cargo (用于安装 rust 相关工具)
- stylua (用于 Lua 格式化)
- black (用于 Python 格式化)
- prettier (用于前端代码格式化)

## 项目特色

### 1. 高度模块化

- 清晰的目录结构
- 独立的插件配置文件
- 易于维护和定制

### 2. 智能补全

- 支持 `cmp` 和 `blink` 两种补全引擎
- 支持多种补全源
- GitHub Copilot 集成
- 智能路径补全

### 3. LSP 支持

- 开箱即用的 LSP 配置
- 多种语言支持
- 实时诊断和修复建议

### 4. 高效搜索

- 支持 telescope 和 fzf 两种搜索引擎
- 快速文件跳转
- 全文内容搜索

### 5. 美观界面

- 多主题支持（tokyonight、evergarden、catppuccin）
- 支持透明背景
- 现代化启动界面

## 项目结构

### 文件结构

```plaintext
📁 ~/.config/nvim
├── 📁 lua/
│ ├── 📁 core/ # 核心配置
│ │ ├── 📄 init.lua # 入口文件
│ │ ├── 📄 options.lua # 基础设置
│ │ ├── 📄 keymaps.lua # 键位映射
│ │ └── 📄 config.lua # 用户配置
│ └── 📁 plugins/ # 插件配置
├── 📁 snippets/ # 代码片段
└── 📄 init.lua # 主入口文件
```

### 键位映射结构

- `<Space>` 作为 leader 键
- 常用功能映射：
  - `<leader>f` - 文件操作
  - `<leader>g` - Git 操作
  - `<leader>c` - LSP 相关
  - `<leader>t` - 终端操作
  - `<leader>s` - 会话管理
  - `<leader>x` - 诊断列表
  - `<leader>r` - 替换操作

### 用户配置结构

用户可以通过修改 `lua/core/config.lua` 来自定义配置：

- 主题选择
- 搜索工具选择
- 补全引擎选择
- 自动命令开关
- LSP 工具选择

## 贡献指南

欢迎提交 Issue 和 Pull Request！在提交之前，请确保：

1. 代码符合项目的代码风格
2. 新功能有适当的文档说明
3. 不破坏现有功能

## 许可证

MIT License

## 致谢

感谢以下项目的启发：

- LazyVim
