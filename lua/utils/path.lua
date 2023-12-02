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
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
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
    root = root and vim.fs.dirname(root) or vim.loop.cwd() --[[@as string]]
    return root
end

function M.listdir_by_filetype(p, filetype)
    return vim.fn.globpath(p, ("*.%s"):format(filetype), false, true)
end

return M
