local schemastore = { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } }

local render_markdown = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { "markdown", "Avante" },
    sign = { enabled = false },
  },
}

return {
  schemastore,
  render_markdown,
}
