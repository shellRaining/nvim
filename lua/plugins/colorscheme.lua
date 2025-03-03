local colorscheme = require("core.config").colorscheme
local transparent = require("core.config").transparent

local tokyonight_config = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  cond = colorscheme == "tokyonight",
  config = function()
    require("tokyonight").setup({
      style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = transparent, -- Enable this to disable setting the background color
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}

local evergarden_config = {
  "comfysage/evergarden",
  priority = 1000,
  cond = colorscheme == "evergarden",
  config = function()
    require("evergarden").setup({
      transparent_background = transparent,
      contrast_dark = "medium",
    })
    vim.cmd.colorscheme("evergarden")
  end,
}

local catppuccin_config = {
  "catppuccin/nvim",
  name = "catppuccin",
  cond = colorscheme == "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = transparent, -- disables setting the background color.
      integrations = {
        fidget = true,
        noice = true,
        notify = true,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

local monokai_config = {
  "polirritmico/monokai-nightasty.nvim",
  cond = colorscheme == "monokai",
  lazy = false,
  priority = 1000,
  config = function()
    require("monokai-nightasty").setup({
      dark_style_background = "default",
      light_style_background = "default",
    })
    vim.cmd.colorscheme("monokai-nightasty")
  end,
}

return {
  tokyonight_config,
  evergarden_config,
  catppuccin_config,
  monokai_config,
}
