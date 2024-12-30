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

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle blame line" },
    { "<leader>gD", "<cmd>Gitsigns diffthis<cr>", desc = "Open diff view" },
    { "<leader>gd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle deleted lines" },
    { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset current hunk" },
    { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset current buffer" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview current hunk" },
    {
      "<c-k>",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          vim.cmd("Gitsigns prev_hunk")
        end
      end,
      desc = "Jump to the prev hunk",
    },
    {
      "<c-j>",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          vim.cmd("Gitsigns next_hunk")
        end
      end,
      desc = "Jump to the next hunk",
    },
  },
  opts = {},
}

local persistence = {
  "folke/persistence.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      mode = "n",
      desc = "load the session for the current directory",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      mode = "n",
      desc = "select a session to load",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      mode = "n",
      desc = "load the last session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      mode = "n",
      desc = "stop Persistence => session won't be saved on exit",
    },
  },
  opts = {},
}

local term = {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>tf", "<cmd>ToggleFloatTerm<cr>", desc = "Toggle float term" },
    { "<leader>tg", "<cmd>ToggleLazygitTerm<cr>", desc = "Toggle lazygit term" },
  },
  config = function()
    local toggleterm = require("toggleterm")
    local terms = require("toggleterm.terminal").Terminal
    local terminals = {
      float = nil,
      lazygit = nil,
    }

    toggleterm.setup({
      start_in_insert = true,
      shade_terminals = true,
      shading_factor = 1,
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.25
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.25
        end
      end,
      on_open = function()
        vim.wo.spell = false
      end,
      highlights = {
        Normal = {
          link = "Normal",
        },
        NormalFloat = {
          link = "NormalFloat",
        },
        FloatBorder = {
          link = "FloatBorder",
        },
      },
    })

    local on_open = function(term)
      vim.keymap.set("t", "<esc>", "<c-\\><c-n><cmd>close<cr>", { silent = true, buffer = term.bufnr })
    end
    local on_close = function(term)
      vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { silent = true, buffer = term.bufnr })
    end
    terminals.float = terms:new({
      hidden = true,
      count = 120,
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = on_open,
      on_close = on_close,
    })
    terminals.lazygit = terms:new({
      cmd = "lazygit",
      count = 130,
      hidden = true,
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        on_open(term)
        vim.keymap.set("i", "q", "<cmd>close<cr>", { silent = true, buffer = term.bufnr })
      end,
      on_close = on_close,
    })

    vim.api.nvim_create_user_command("ToggleFloatTerm", function()
      terminals.float:toggle()
    end, {})
    vim.api.nvim_create_user_command("ToggleLazygitTerm", function()
      terminals.lazygit:toggle()
    end, {})
  end,
}

return {
  grug_far,
  moveline,
  wakatime,
  gx,
  gitsigns,
  persistence,
  term,
}
