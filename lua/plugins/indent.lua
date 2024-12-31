local indent = require("core.config").indent

local snack_config = {
  "folke/snacks.nvim",
  cond = indent == "snack",
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
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
    indent = {
      enable = indent == "hlchunk",
    },
  },
}

local indent_blankline_config = {
  "lukas-reineke/indent-blankline.nvim",
  cond = indent == "indent-blankline",
  opts = {},
}

local indentMini_config = {
  "echasnovski/mini.indentscope",
  cond = indent == "indentmini",
  opts = {},
}

local guess_indent_config = {
  "nmac427/guess-indent.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  cmd = { "GuessIndnet" },
  opts = {},
}

return {
  hlchunk_config,
  snack_config,
  indent_blankline_config,
  indentMini_config,
  guess_indent_config,
}
