local indent = require("core.config").indent

local snackConfig = {
  "folke/snacks.nvim",
  opts = {
    indent = {
      scope = {
        enabled = false,
      },
    },
  },
}

local hlchunkConfig = {
  "shellRaining/hlchunk.nvim",
  opts = {
    chunk = {
      enable = true,
      use_treesitter = true,
      notify = true,
      chars = {
        left_arrow = "━",
        horizontal_line = "━",
        vertical_line = "┃",
        left_top = "┏",
        left_bottom = "┗",
        right_arrow = "━",
      },
      style = {
        { fg = "#806d9c" },
        { fg = "#f35336" },
      },
      textobject = "ic",
      duration = 100,
      delay = 50,
    },
  },
}

local indentBlanklineConfig = {
  "lukas-reineke/indent-blankline.nvim",
  opts = {},
}

local indentMiniConfig = {
  "echasnovski/mini.indentscope",
  opts = {},
}

local indent2Config = {
  snack = snackConfig,
  indentmini = indentMiniConfig,
  hlchunk = hlchunkConfig,
  ["indent-blankline"] = indentBlanklineConfig,
}

return indent == 'custom' and {
  hlchunkConfig,
  snackConfig
} or {
  indent2Config[indent],
}