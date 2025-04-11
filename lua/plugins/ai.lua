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
      enable = false,
      auto_trigger = false,
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
    copilot_model = "gpt-4o-copilot",
  },
}

local prompts = {
  Explain = "Please explain how the following code works, and always response in 中文",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Review = "Please review the following code and provide suggestions for improvement, and always response in 中文",
  Refactor = "Please refactor the following code to improve its clarity and readability, and always response in 中文",
  BetterNamings = "Please provide better names for the following variables and functions, and always response in 中文",
  FixCode = "Please fix the following code to make it work as intended, and always response in 中文",
  FixError = "Please explain the error in the following text and provide a solution, and always response in 中文",
  Documentation = "Please provide documentation for the following code, and always response in 中文",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger, and always response in 中文",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger, and always response in 中文",
  -- Text related prompts
  Summarize = "Please summarize the following text,",
  Spelling = "Please correct any grammar and spelling errors in the following text,",
  Wording = "Please improve the grammar and wording of the following text,",
  Concise = "Please rewrite the following text to make it more concise,",
}
local copilot_chat = {
  "CopilotC-Nvim/CopilotChat.nvim",
  build = "make tiktoken", -- Only on MacOS or Linux
  keys = {
    { "<leader>ae", "<cmd>CopilotChatExplain<cr>", mode = { "n", "x" }, desc = "Explain code" },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", mode = { "n", "x" }, desc = "Review code" },
    { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", mode = { "n", "x" }, desc = "Refactor code" },
    { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", mode = { "n", "x" }, desc = "Better Naming" },
    { "<leader>af", "<cmd>CopilotChatFix<cr>", mode = { "n", "x" }, desc = "Fix Diagnostic" },
    { "<leader>av", "<cmd>CopilotChatVisual<cr>", mode = "x", desc = "Open in vertical split" },
    { "<leader>ax", "<cmd>CopilotChatInline<cr>", mode = "x", desc = "Inline chat" },
    { "<leader>am", "<cmd>CopilotChatCommit<cr>", desc = "Generate commit message for all changes" },
    {
      "<leader>ai",
      function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end,
      desc = "Ask input",
    },
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatBuffer " .. input)
        end
      end,
      desc = "Quick chat",
    },
    {
      "<leader>ap",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat - Prompt actions",
    },
    { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
    { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
    { "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "Select Models" },
    { "<leader>aa", "<cmd>CopilotChatAgents<cr>", desc = "Select Agents" },
  },
  opts = {
    question_header = "## User ",
    answer_header = "## Copilot ",
    error_header = "## Error ",
    prompts = prompts,
    auto_follow_cursor = false, -- Don't follow the cursor after getting response
    model = "claude-3.7-sonnet",
    mappings = {
      complete = {
        detail = "Use @<Tab> or /<Tab> for options.",
        insert = "<Tab>",
      },
      close = {
        normal = "q",
        insert = "<C-c>",
      },
      reset = {
        normal = "<C-x>",
        insert = "<C-x>",
      },
      accept_diff = {
        normal = "<C-y>",
        insert = "<C-y>",
      },
      show_help = {
        normal = "g?",
      },
    },
  },
  config = function(_, opts)
    local chat = require("CopilotChat")
    chat.setup(opts)

    local select = require("CopilotChat.select")
    vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = "*", range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command("CopilotChatInline", function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = "float",
          relative = "cursor",
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = "*", range = true })

    -- Restore CopilotChatBuffer
    vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = "*", range = true })

    -- Custom buffer for CopilotChat
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
        -- Get current filetype and set it to markdown if the current filetype is copilot-chat
        local ft = vim.bo.filetype
        if ft == "copilot-chat" then
          vim.bo.filetype = "markdown"
        end
      end,
    })
  end,
}

return {
  copilot,
  copilot_chat,
}
