local path = require("utils.path")

local M = {}

-- this will return a function that calls telescope.
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = path.get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        if opts.cwd and opts.cwd ~= vim.loop.cwd() then
            opts.attach_mappings = function(_, map)
                map("i", "<a-c>", function()
                    local action_state = require("telescope.actions.state")
                    local line = action_state.get_current_line()
                    M.telescope(
                        params.builtin,
                        vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
                    )()
                end)
                return true
            end
        end

        require("telescope.builtin")[builtin](opts)
    end
end

return M
