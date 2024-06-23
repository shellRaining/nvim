local api = require("utils.api")

local M = {
    -- ui settings
    show_winbar = true,
    transparent = true,
    float_border = true,
    -- edit settings
    auto_save = true,
    auto_restore_cursor_position = true,
    auto_remove_new_lines_comment = true,
    auto_hl_on_yank = true,
    auto_resize_window = true,
    auto_set_quit_map = true,
    auto_spell_check_text = true,
    auto_reload_changed_file = true,
    auto_switch_relative_number = false,
    -- directory settings
    storage_directory = api.path.join(vim.fn.stdpath("data"), "store"),
    mason_install_directory = api.path.join(vim.fn.stdpath("data"), "mason"),
    global_config_directory = api.path.join(vim.fn.stdpath("config"), "config"),
    spell_config_directory = api.path.join(vim.fn.stdpath("config"), "spell"),
}

return M
