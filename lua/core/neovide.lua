if not vim.g.neovide then
  return
end

-- " g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_opacity = 0.91
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

vim.g.neovide_hide_mouse_when_typing = true

-- cursor animation
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- keymap
vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.cmd("command -nargs=0 NeovideToggleFullscreen :let g:neovide_fullscreen = !g:neovide_fullscreen")

vim.keymap.set("v", "<D-c>", '"+y') -- Copy
vim.keymap.set({ "i", "c", "v" }, "<D-v>", "<C-R>+", {
  desc = "Paste in insert mode and console mode... due to neovide not support <D-v>",
})
vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })

-- Paste in normal mode
vim.keymap.set("n", "<D-v>", '"+p', {
  desc = "Paste in normal mode... due to neovide not support <D-v>",
})

-- Toggle fullscreen
vim.keymap.set("n", "<F12>", "<cmd>NeovideToggleFullscreen<CR>", {
  desc = "Toggle fullscreen",
})

-- tab jump
local function make_tabmap(key, tabnum)
  vim.keymap.set("n", "<D-" .. key .. ">", function()
    vim.cmd(tabnum .. "tabnext")
  end, { noremap = true, silent = true, desc = "Go to tab " .. tabnum })
end

for i = 1, 9 do
  make_tabmap(tostring(i), i)
end

-- vim.g.neovide_input_ime = false
-- local function set_ime(args)
--   if args.event:match("Enter$") then
--     vim.g.neovide_input_ime = true
--   else
--     vim.g.neovide_input_ime = false
--   end
-- end
--
-- local ime_input_augroup = vim.api.nvim_create_augroup("ime_input", { clear = true })
--
-- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
--   group = ime_input_augroup,
--   pattern = "*",
--   callback = set_ime,
-- })
--
-- vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
--   group = ime_input_augroup,
--   pattern = "[/\\?]",
--   callback = set_ime,
-- })
