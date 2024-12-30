local yazi = {
  "mikavilpas/yazi.nvim",
  lazy = true,
  keys = {
    {
      "<leader>-",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
}

return {
  yazi,
}
