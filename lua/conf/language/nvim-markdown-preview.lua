local M = {}

function M.load()
    -- markdown preview theme：
    --  github
    --  solarized-light
    --  solarized-dark
    vim.g.nvim_markdown_preview_theme = "github"
    -- markdown
    vim.g.nvim_markdown_preview_format = "gfm"
end

return M
