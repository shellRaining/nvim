local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  change_detection = {
    enabled = false,
    notify = false,
  },
  ui = {
    border = "double",
  },
  dev = {
    path = "~/Documents/nvim_dev/",
  },

  spec = {
    -- 导入所有插件模块
    { "nvim-lua/plenary.nvim", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "stevearc/dressing.nvim", opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        presets = {
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        lsp = {
          signature = {
            enabled = require("core.config").signature == "noice",
          },
        },
        routes = {
          {
            filter = {
              find = "No information available",
            },
            opts = { skip = true },
          },
        },
      },
      dependencies = {
        "rcarriga/nvim-notify",
      },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      ---@class wk.Opts
      opts = {
        preset = "modern",
        spec = {
          { "<leader>", desc = "Map leader" },
          { "<leader>a", desc = "AI", mode = { "n", "x" } },
          { "<leader>f", desc = "Find" },
          { "<leader>g", desc = "Git" },
          { "<leader>c", desc = "LSP", mode = { "n", "x" } },
          { "<leader>x", desc = "Quickfix" },
          { "<leader>s", desc = "Session" },
          { "<leader>t", desc = "Terminal" },
          { "<leader>r", desc = "Replace", mode = { "n", "x" } },
          { "<leader>p", desc = "Snippets", mode = { "n", "x" } },
          { "<leader>o", desc = "Open Files" },
          { "<leader>1", desc = "Yazi Explorer" },
          { "<leader>2", desc = "Aerial Outline" },
        },
      },
    },
    { import = "plugins.colorscheme" },
    { import = "plugins.find" },
    { import = "plugins.quickfix" },
    { import = "plugins.indent" },
    { import = "plugins.dashboard" },
    { import = "plugins.cmp" },
    { import = "plugins.lsp" },
    { import = "plugins.treesitter" },
    { import = "plugins.move" },
    { import = "plugins.ui" },
    { import = "plugins.ai" },
    { import = "plugins.lang" },
    { import = "plugins.snippets" },

    -- 不好分类的插件
    { import = "plugins.tools" },

    -- 开发中的工具库
    {
      "shellRaining/devtools.nvim",
      dev = true,
      ---@module 'devtools'
      ---@type DevTools.DevToolsConfig
      opts = {
        log_path = "/tmp/myNvim.log",
        rewrite = true,
      },
    },
    {
      "shellRaining/mult_level_cache",
      dev = true,
    },
  },
})
