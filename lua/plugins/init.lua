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

  spec = {
    -- 导入所有插件模块
    { "nvim-lua/plenary.nvim", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "stevearc/dressing.nvim", opts = {} },
    { "nvim-tree/nvim-web-devicons" },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      ---@class wk.Opts
      opts = {
        preset = "modern",
        ---@type wk.Spec
        spec = {
          { "<leader>", desc = "Map leader" },
          { "<leader>f", desc = "Find" },
          { "<leader>g", desc = "Git" },
          { "<leader>c", desc = "LSP" },
          { "<leader>x", desc = "Quickfix" },
          { "<leader>s", desc = "Session" },
          { "<leader>t", desc = "Terminal" },
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
    { import = "plugins.files" },
    { import = "plugins.ai" },
    { import = "plugins.lang" },

    -- 不好分类的插件
    { import = "plugins.tools" },
  },
})
