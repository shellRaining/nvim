local colorscheme = require("core.config").colorscheme

local tokyonightConfig = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}

local evergardenConfig = {
  "comfysage/evergarden",
  priority = 1000,
  config = function()
    require("evergarden").setup({
      transparent_background = true,
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
