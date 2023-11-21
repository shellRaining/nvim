local M = {}

function M.join(...)
    return table.concat(vim.tbl_flatten({ ... }), "/")
end

function M.exists(p)
    return vim.fn.filereadable(p) == 1
end

---@param bufnr number? default is current buffer
---@return string | nil
local function get_root_by_lsp(bufnr)
    bufnr = bufnr or 0
    local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    if #clients == 0 or not clients[1].config or not clients[1].config.workspace_folders then
        return nil
    end
    return clients[1].config.workspace_folders[1].name
end

---@param bufnr number? default is current buffer
---@return string
function M.get_root(bufnr)
    bufnr = bufnr or 0

    -- get root by lsp
    local root = get_root_by_lsp(bufnr)
    if root then
        return root
    end

    -- get by pattern
    local patterns = {
        ".git",
        ".svn",
        "package.json",
        "Cargo.toml",
        "requirements.txt",
        "Makefile",
        "CMakeLists.txt",
        ".gitignore",
    }
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        path = vim.loop.cwd() --[[@as string]]
    end
    root = vim.fs.find(patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
    return root
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
-- function M.get_root()
--     local path = vim.api.nvim_buf_get_name(0) --[[@as string]]
--     path = path ~= "" and vim.loop.fs_realpath(path) or nil
--     ---@type string[]
--     local roots = {}
--     if path then
--         for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
--             local workspace = client.config.workspace_folders
--             local paths = workspace
--                     and vim.tbl_map(function(ws)
--                         return vim.uri_to_fname(ws.uri)
--                     end, workspace)
--                 or client.config.root_dir and { client.config.root_dir }
--                 or {}
--             for _, p in ipairs(paths) do
--                 local r = vim.loop.fs_realpath(p)
--                 if path:find(r, 1, true) then
--                     roots[#roots + 1] = r
--                 end
--             end
--         end
--     end
--     table.sort(roots, function(a, b)
--         return #a > #b
--     end)
--     ---@type string?
--     local root = roots[1]
--     if not root then
--         path = path and vim.fs.dirname(path) or vim.loop.cwd()
--         ---@type string?
--         root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
--         root = root and vim.fs.dirname(root) or vim.loop.cwd()
--     end
--     ---@cast root string
--     return root
-- end

return M
