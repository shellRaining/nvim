require("core.setting")
require("core.platform")
require("core.filetype")
require("core.highlight")
require("core.options")
require("core.mapping")
require("core.plugins")
require("core.neovide")
require("core.after")
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
vim.keymap.set("", "<f1>", toggle_profile)
