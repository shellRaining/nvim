local M = {
    requires = {
        "cool-chunk",
        -- "hlchunk.mods.indent",
    },
    event = { "BufReadPre", "BufNewFile" },
}

function M.load()
    M.cool_chunk.setup({})
end

function M.after() end

return M
