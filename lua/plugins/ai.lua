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

return {
  copilot,
}
