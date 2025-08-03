local M = {}

local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  options = vim.tbl_extend("force", options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

local scroll_screen_up = function()
  vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "k")
end

local scroll_screen_down = function()
  vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "j")
end

local move_cursor_up = function()
  return vim.v.count > 0 and "k" or "gk"
end

local move_cursor_down = function()
  return vim.v.count > 0 and "j" or "gj"
end

-- basic set
map("n", "&", "*", { desc = "Search word under cursor" })
map("n", "<leader><esc>", "<cmd>qa!<cr>", { desc = "Escape Neovim" })
map({ "n", "v" }, "<c-u>", scroll_screen_up, { desc = "Move 1/4 screen up" })
map({ "n", "v" }, "<c-d>", scroll_screen_down, { desc = "Move 1/4 screen down" })
map({ "n", "v" }, "<c-0>", "^", { desc = "Move to first non-blank character of line" })
map({ "n", "x" }, "k", move_cursor_up, { expr = true, desc = "Move up one line" })
map({ "n", "x" }, "j", move_cursor_down, { expr = true, desc = "Move down one line" })
map("v", "<", "<gv", { desc = "move the select_hunk to left" })
map("v", ">", ">gv", { desc = "move the select_hunk to right" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "stop highlight search when escape insert mode" })
map("s", "<bs>", "<C-g>c", { desc = "delete selection in insert mode" })

-- console mapping
map("c", "<m-p>", "<up>", { desc = "Look up history" })
map("c", "<m-n>", "<down>", { desc = "Look down history" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Escape terminal insert mode" })

-- windows mapping
map("n", "<c-s>", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map({ "n", "t" }, "<c-h>", "<cmd>wincmd h<cr>", { desc = "goto left window" })
map({ "n", "t" }, "<c-j>", "<cmd>wincmd j<cr>", { desc = "goto lower window" })
map({ "n", "t" }, "<c-k>", "<cmd>wincmd k<cr>", { desc = "goto upper window" })
map({ "n", "t" }, "<c-l>", "<cmd>wincmd l<cr>", { desc = "goto right window" })
map("n", "<c-q>", "<cmd>q!<cr>", { desc = "quit window" })

-- insert mapping
map("i", "<c-enter>", "<c-o>o", { desc = "Insert new line below" })
map({ "i", "c", "t" }, "<m-w>", "<c-right>", { desc = "Jump to next word in insert mode" })
map({ "i", "c", "t" }, "<m-e>", "<c-right><left>", { desc = "Jump to end of word in insert mode" })
map({ "i", "c", "t" }, "<m-b>", "<c-left>", { desc = "Jump to previous word in insert mode" })
map({ "i", "c", "t" }, "<m-k>", "<up><c-f>", { desc = "Move cursor up in insert mode" })
map({ "i", "c", "t" }, "<m-j>", "<down><c-f>", { desc = "Move cursor down in insert mode" })
map({ "i", "c", "t" }, "<m-h>", "<left>", { desc = "Move cursor left in insert mode" })
map({ "i", "c", "t" }, "<m-l>", "<right>", { desc = "Move cursor right in insert mode" })
map({ "i", "s", "c" }, "jk", "<esc>", { desc = "Escape insert mode" })

-- fold mapping
local function open_folds_in_visual()
  local start_l = vim.fn.line("v")
  local end_l = vim.fn.line(".")
  if start_l > end_l then
    start_l, end_l = end_l, start_l
  end
  for l = start_l, end_l do
    if vim.fn.foldclosed(l) ~= -1 then
      vim.cmd(l .. "foldopen!")
    end
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end
map("v", "zR", function()
  open_folds_in_visual()
end, { desc = "open all fold" })

-- quick file opening
map("n", "<leader>or", function()
  vim.cmd("edit /Users/shellraining/Library/Rime/custom_phrase.txt")
end, { desc = "Open Rime config" })

map("n", "<leader>oz", function()
  vim.cmd("edit /Users/shellraining/Documents/dotfiles/config/zsh/.zshrc")
end, { desc = "Open zsh config" })

map("n", "<leader>ot", function()
  vim.cmd("edit /Users/shellraining/Documents/immersive_translation_rules/rules.json")
end, { desc = "Open translation rules" })

-- lsp mapping
local lsp_tools = require("core.config").lsp_tools
local cmd_groups = {
  definitions = {
    native = vim.lsp.buf.definition,
    telescope = "<cmd>Telescope lsp_definitions<cr>",
    trouble = "<cmd>Trouble lsp_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_definitions ignore_current_line=true<cr>",
  },
  implementations = {
    native = vim.lsp.buf.implementation,
    telescope = "<cmd>Telescope lsp_implementations<cr>",
    trouble = "<cmd>Trouble lsp_implementations<cr>",
    fzf = "<cmd>FzfLua lsp_implementations ignore_current_line=true<cr>",
  },
  references = {
    native = vim.lsp.buf.references,
    telescope = "<cmd>Telescope lsp_references<cr>",
    trouble = "<cmd>Trouble lsp_references<cr>",
    fzf = "<cmd>FzfLua lsp_references ignore_current_line=true<cr>",
  },
  type_definitions = {
    native = vim.lsp.buf.type_definition,
    telescope = "<cmd>Telescope lsp_type_definitions<cr>",
    trouble = "<cmd>Trouble lsp_type_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_typedefs ignore_current_line=true<cr>",
  },
  code_actions = {
    native = vim.lsp.buf.code_action,
    telescope = "<cmd>Telescope lsp_code_actions<cr>",
    trouble = vim.lsp.buf.code_action,
    fzf = "<cmd>FzfLua lsp_code_actions<cr>",
  },
}
map("n", "gd", cmd_groups.definitions[lsp_tools], { desc = "Lsp Definitions" })
map("n", "gi", cmd_groups.implementations[lsp_tools], { desc = "Lsp Implementations" })
map("n", "gr", cmd_groups.references[lsp_tools], { desc = "Lsp References" })
map("n", "gt", cmd_groups.type_definitions[lsp_tools], { desc = "Lsp Type Definitions" })
map("n", "ga", cmd_groups.code_actions[lsp_tools], { desc = "Lsp Code Actions" })
map("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Lsp Rename" })
map("n", "<F8>", function()
  vim.diagnostic.jump({ count = 1, float = false })
end, { desc = "Lsp Next Diagnostic" })
map("n", "<S-F8>", function()
  vim.diagnostic.jump({ count = -1, float = false })
end, { desc = "Lsp Previous Diagnostic" })

return M
