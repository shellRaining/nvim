local colorscheme = require("core.config").colorscheme
local transparent = require("core.config").transparent

local tokyonightConfig = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = transparent, -- Enable this to disable setting the background color
    })
    vim.cmd.colorscheme("tokyonight")
  end,
}

local evergardenConfig = {
  "comfysage/evergarden",
  priority = 1000,
  config = function()
    require("evergarden").setup({
      transparent_background = transparent,
      contrast_dark = "medium",
    })
    vim.cmd.colorscheme("evergarden")
  end,
}

local catppuccinConfig = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = transparent, -- disables setting the background color.
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

local colorscheme2Config = {
  tokyonight = tokyonightConfig,
  evergarden = evergardenConfig,
  catppuccin = catppuccinConfig,
}

return {
  colorscheme2Config[colorscheme],
}
