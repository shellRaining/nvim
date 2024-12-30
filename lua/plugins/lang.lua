local schemastore = { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } }

local render_markdown = {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "Avante" },
  opts = { file_types = { "markdown", "Avante" } },
}

return {
  schemastore,
  render_markdown,
}
