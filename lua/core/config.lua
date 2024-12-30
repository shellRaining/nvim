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

M.autocmdOpts = {
  auto_save = true,
  auto_restore_cursor_position = true,
  auto_remove_new_lines_comment = false,
  auto_hl_on_yank = true,
  auto_resize_window = true,
  auto_set_quit_map = true,
  auto_spell_check_text = true,
  auto_reload_changed_file = true,
}

return M
