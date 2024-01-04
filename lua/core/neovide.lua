if not vim.g.neovide then
    return
end

-- " g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.91
vim.g.neovide_floating_blur_amount_x = 4.0
vim.g.neovide_floating_blur_amount_y = 4.0

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- full screen
-- vim.g.neovide_fullscreen = true
-- vim.g.neovide_profiler = false



vim.g.neovide_input_use_logo = 1
vim.g.neovide_input_macos_alt_is_meta = 1

-- cursor animation
-- vim.g.neovide_cursor_animation_length = 0.13
-- vim.g.neovide_cursor_trail_size = 0.8
-- vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_mode = "ripple"

vim.opt.guifont = { "JetBrainsMono NFM:h12" }
-- vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }

vim.cmd("command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen")
local map = require("utils.api").map
map.bulk_register({
    {
        mode = { "i", "c", "t", "v" },
        lhs = "<D-v>",
        rhs = "<C-R>+",
        options = {},
        description = "Paste in insert mode and console mode... due to neovide not support <D-v>",
    },
    {
        mode = { "n" },
        lhs = "<D-v>",
        rhs = '"+p',
        options = {},
        description = "Paste in normal mode... due to neovide not support <D-v>",
    },
    {
        mode = { "n" },
        lhs = "<F12>",
        rhs = "<cmd>NeovideToggleFullscreen<CR>",
        options = {},
        description = "Toggle fullscreen",
    },
})

-- IME setting
-- vim.g.neovide_input_ime = false
-- local function set_ime(args)
--     if args.event:match("Enter$") then
--         vim.g.neovide_input_ime = true
--     else
--         vim.g.neovide_input_ime = false
--     end
-- end
--
-- local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
--     group = ime_input,
--     pattern = "*",
--     callback = set_ime
-- })
--
-- vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
--     group = ime_input,
--     pattern = "[/\\?]",
--     callback = set_ime
-- })

