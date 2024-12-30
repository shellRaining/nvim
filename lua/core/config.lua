local M = {}

---@type "tokyonight" | "evergarden" | "catppuccin"
M.colorscheme = "evergarden"
M.transparent = true

---@type "telescope" | "fzf-lua"
M.find = "fzf-lua"

---@type "trouble"
M.quickfix = "trouble"

---@type "hlchunk" | "indent-blankline" | "snack" | "indentmini" | "custom"
M.indent = "custom"

---@type "dashboard" | "snack"
M.dashboard = "dashboard"

return M
