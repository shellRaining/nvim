local M = {}

local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  options = vim.tbl_extend("force", options, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

local scrollScreenUp = function()
  vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "k")
end

local scrollScreenDown = function()
  vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "j")
end

local moveCursorUp = function()
  return vim.v.count > 0 and "k" or "gk"
end

local moveCursorDown = function()
  return vim.v.count > 0 and "j" or "gj"
end

-- basic set
map("n", "&", "*", { desc = "Search word under cursor" })
map("n", "<leader><esc>", "<cmd>qa!<cr>", { desc = "Escape Neovim" })
map({ "n", "v" }, "<c-u>", scrollScreenUp, { desc = "Move 1/4 screen up" })
map({ "n", "v" }, "<c-d>", scrollScreenDown, { desc = "Move 1/4 screen down" })
map({ "n", "v" }, "<c-0>", "^", { desc = "Move to first non-blank character of line" })
map({ "n", "x" }, "k", moveCursorUp, { expr = true, desc = "Move up one line" })
map({ "n", "x" }, "j", moveCursorDown, { expr = true, desc = "Move down one line" })
map("v", "<", "<gv", { desc = "move the select_hunk to left" })
map("v", ">", ">gv", { desc = "move the select_hunk to right" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "stop highlight search when escape insert mode" })

-- console mapping
map("c", "<m-p>", "<up>", { desc = "Look up history" })
map("c", "<m-n>", "<down>", { desc = "Look down history" })
map("t", "<esc>", "<c-\\><c-n>", { desc = "Escape terminal insert mode" })
map("t", "<c-h>", "<cmd>wincmd h<cr>", { desc = "goto left window" })
map("t", "<c-j>", "<cmd>wincmd j<cr>", { desc = "goto lower window" })
map("t", "<c-k>", "<cmd>wincmd k<cr>", { desc = "goto upper window" })
map("t", "<c-l>", "<cmd>wincmd l<cr>", { desc = "goto right window" })

-- windows mapping
map("n", "<c-s>", "<cmd>vsplit<cr>", { desc = "split window vertically" })
map("n", "<c-l>", "<c-w>l", { desc = "goto right window" })
map("n", "<c-h>", "<c-w>h", { desc = "goto left window" })
map("n", "<c-j>", "<c-w>j", { desc = "goto lower window" })
map("n", "<c-k>", "<c-w>k", { desc = "goto upper window" })
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

return M
