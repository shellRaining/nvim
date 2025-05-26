-- 基础配置项
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- 基础编辑器选项
local opt = vim.opt

-- UI 显示相关
opt.showmode = false -- 不显示模式
opt.signcolumn = "yes" -- 启用符号列
opt.cursorline = true -- 启用光标行高亮
opt.termguicolors = true -- 启用真彩色
opt.ruler = true -- 启用行号
opt.list = true -- 显示行号
opt.fillchars = "eob: " -- 填充字符
opt.laststatus = 3 -- 状态栏

-- 行号和缩进设置
opt.number = true -- 显示行号
opt.numberwidth = 2 -- 行号宽度
opt.breakindent = true -- 启用断行缩进
opt.smartindent = true -- 智能缩进
opt.linebreak = true -- 行断开
opt.wrap = false -- 启用自动换行
opt.expandtab = true -- 启用 tab 自动展开
opt.shiftwidth = 2 -- 设置平移距离
opt.tabstop = 2 -- 设置 tab 宽度
opt.softtabstop = 2 -- 设置软 tab 宽度

-- 编辑体验
opt.scrolloff = 21 -- 光标离上下边缘的距离
opt.mouse = "a" -- 启用鼠标
opt.updatetime = 800 -- 更新时间
opt.timeoutlen = 800 -- 超时时间
opt.undofile = true -- 启用撤销文件
opt.swapfile = false -- 禁用交换文件

-- 搜索和补全
opt.ignorecase = true -- 忽略大小写
opt.smartcase = true -- 智能大小写
opt.completeopt = "menuone,noselect" -- 启用补全菜单
opt.pumheight = 5 -- 补全菜单高度

-- 特殊字符和编码
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- 设置行尾字符
opt.iskeyword = "@,48-57,_,192-255" -- 关键字
opt.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,latin1" -- 文件编码

-- 窗口分割
opt.splitright = true -- 启用右分割
opt.splitbelow = true -- 启用下分割

-- 其他设置
opt.inccommand = "split" -- 启用即时命令
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,globals" -- 会话选项

-- 设置剪贴板
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- 折叠
opt.foldlevel = 99 -- 折叠级别

return {}
