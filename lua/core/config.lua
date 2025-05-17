local M = {}

---@type "tokyonight" | "evergarden" | "catppuccin"
M.colorscheme = "tokyonight"
M.transparent = false

---@type "telescope" | "fzf-lua"
M.find = "fzf-lua"

---@type "trouble"
M.quickfix = "trouble"

---@type "hlchunk" | "indent-blankline" | "snack" | "indentmini"
M.indent = "indentmini"

---@type "dashboard" | "snack"
M.dashboard = "dashboard"

---@type "cmp" | "blink"
M.cmp = "blink"

---@type "blink" | "lsp_signature" | "noice"
M.signature = "blink"

M.autocmd_opts = {
  auto_save = true,
  auto_restore_cursor_position = true,
  auto_remove_new_lines_comment = false,
  auto_hl_on_yank = true,
  auto_resize_window = true,
  auto_set_quit_map = true,
  auto_spell_check_text = true,
  auto_reload_changed_file = true,
}

local function join(...)
  return table.concat(vim.iter({ ... }):flatten():totable(), "/")
end

M.paths = {
  spell_config_directory = join(vim.fn.stdpath("config"), "spell"),
}

---@type "fzf" | "trouble" | "telescope" | "native"
M.lsp_tools = "fzf"

M.disabled_auto_format = {
  "markdown",
}

return M
