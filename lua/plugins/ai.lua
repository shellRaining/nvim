local copilot = {
  "zbirenbaum/copilot.lua",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    {
      "<c-l>",
      mode = { "i", "s" },
      function()
        local copilot_suggestion = require("copilot.suggestion")
        if copilot_suggestion.is_visible() then
          copilot_suggestion.accept()
        end
      end,
      desc = "copilot suggestion accept",
    },
  },
  opts = {
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = {
        accept = false,
        accept_word = false,
        accept_line = false,
        next = false,
        prev = false,
        dismiss = false,
      },
    },
    filetypes = {
      markdown = true,
    },
  },
}

local avante = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  version = false,
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    instructions_file = "avante.md",
    -- for example
    provider = "copilot",
    -- providers = {
    --   claude = {
    --     endpoint = "https://api.anthropic.com",
    --     model = "claude-sonnet-4-20250514",
    --     timeout = 30000, -- Timeout in milliseconds
    --     extra_request_body = {
    --       temperature = 0.75,
    --       max_tokens = 20480,
    --     },
    --   },
    --   moonshot = {
    --     endpoint = "https://api.moonshot.ai/v1",
    --     model = "kimi-k2-0711-preview",
    --     timeout = 30000, -- Timeout in milliseconds
    --     extra_request_body = {
    --       temperature = 0.75,
    --       max_tokens = 32768,
    --     },
    --   },
    -- },
    selector = {
      --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
      --- @type avante.SelectorProvider
      provider = "fzf",
      -- Options override for custom providers
      provider_opts = {},
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "stevearc/dressing.nvim", -- for input provider dressing
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

return {
  copilot,
  avante,
}
