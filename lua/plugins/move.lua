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

local flash = {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}

return {
  moveline,
  flash,
}
