if not vim.g.neovide then
    return
end

-- " g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 1
-- vim.g.transparency = 0.8
-- vim.g.neovide_floating_blur_amount_x = 2.0
-- vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_input_use_logo = 1
vim.g.neovide_input_macos_alt_is_meta = 1

vim.g.neovide_cursor_animation_length = 0.05
vim.g.neovide_cursor_vfx_mode = "ripple"

vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }
-- vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h12" }
