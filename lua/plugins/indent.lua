local indent = require("core.config").indent

local snack_config = {
  "folke/snacks.nvim",
  cond = indent == "snack",
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    indent = {
      scope = {
        enabled = false,
      },
    },
  },
}

local hlchunk_config = {
  "shellRaining/hlchunk.nvim",
  dev = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  ---@module 'hlchunk'
  ---@type HlChunk.UserConf
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
      duration = 300,
      delay = 200,
    },
    indent = {
      enable = indent == "hlchunk",
      delay = 50
    },
  },
}

local indent_blankline_config = {
  "lukas-reineke/indent-blankline.nvim",
  cond = indent == "indent-blankline",
  opts = {},
}

local indentMini_config = {
  "nvimdev/indentmini.nvim",
  cond = indent == "indentmini",
  opts = {},
}

local guess_indent_config = {
  "nmac427/guess-indent.nvim",
  opts = {},
}

return {
  hlchunk_config,
  snack_config,
  indent_blankline_config,
  indentMini_config,
  guess_indent_config,
}
