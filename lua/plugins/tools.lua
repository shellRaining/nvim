local grug_far = {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>sa",
      function()
        require("grug-far").open({})
      end,
      desc = "Search and replace all the project",
    },
    {
      "<leader>sv",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Search and replace selected line",
    },
    {
      "<leader>sc",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Search and replace current buffer",
    },
  },
  opts = function()
    vim.g.maplocalleader = " "
    return {}
  end,
}

return {
  grug_far,
}
