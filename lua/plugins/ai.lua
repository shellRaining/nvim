local copilot = {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
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
    {
      "<leader>c",
    },
  },
  opts = {
    suggestion = {
      enable = true,
      auto_trigger = true,
      keymap = false,
    },
    filetypes = {
      markdown = true,
    },
  },
}

return {
  copilot,
}
