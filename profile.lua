local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.o.number = true

require("lazy").setup({
    {
        "shellRaining/hlchunk.nvim",
        -- tag = "v1.3.0",
        branch = 'main',
        lazy = true,
        event = { "BufReadPre", "BufAdd", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = { enable = false },
                indent = { enable = true },
                blank = { enable = false },
                line_num = { enable = false },
            })
        end,
    },
    -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    -- {
    --     "nvimdev/indentmini.nvim",
    --     config = function()
    --         require("indentmini").setup() -- use default config
    --     end,
    -- },
    { "stevearc/profile.nvim" },
})
local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
    require("profile").instrument_autocmds()
    if should_profile:lower():match("^start") then
        require("profile").start("*")
    else
        require("profile").instrument("*")
    end
end

local function toggle_profile()
    local prof = require("profile")
    local home = vim.fn.expand("~/Desktop")
    if prof.is_recording() then
        prof.stop()
        vim.ui.input(
            { prompt = "Save profile to:", completion = "file", default = home .. "/profile.json" },
            function(filename)
                if filename then
                    prof.export(filename)
                    vim.notify(string.format("Wrote %s", filename))
                end
            end
        )
    else
        prof.start("*")
    end
end
vim.g.mapleader = " "
vim.keymap.set("", "<f1>", toggle_profile)
require("core.mapping")
