local quickfix = require("core.config").quickfix

local trouble_config = {
  "folke/trouble.nvim",
  cond = quickfix == "trouble",
  opts = function()
    -- Automatically Open Trouble Quickfix
    vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      callback = function()
        vim.cmd([[Trouble qflist open]])
      end,
    })
    return {}
  end,
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}

return {
  trouble_config,
}
