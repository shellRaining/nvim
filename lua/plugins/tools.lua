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

local moveline = {
  "fedepujol/move.nvim",
  keys = {
    { "<M-k>", "<cmd>MoveLine(-1)<cr>", desc = "Move line up" },
    { "<M-j>", "<cmd>MoveLine(1)<cr>", desc = "Move line down" },
    { "<M-k>", "<cmd>MoveBlock(-1)<cr>", mode = "v", desc = "Move selected lines up" },
    { "<M-j>", "<cmd>MoveBlock(1)<cr>", mode = "v", desc = "Move selected lines down" },
  },
  opts = {},
}

local wakatime = { "wakatime/vim-wakatime", lazy = false }

local gx = {
  "chrishrb/gx.nvim",
  keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
  cmd = { "Browse" },
  opts = {
    open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
    handlers = {
      plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
      github = true, -- open github issues
      brewfile = true, -- open Homebrew formulaes and casks
      package_json = true, -- open dependencies from package.json
      search = false, -- search the web/selection on the web if nothing else is found
    },
    handler_options = {
      search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
    },
  },
}

return {
  grug_far,
  moveline,
  wakatime,
  gx,
}
