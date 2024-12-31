local colorscheme = require("core.config").colorscheme

local grug_far = {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>ra",
      function()
        require("grug-far").open({})
      end,
      desc = "Search and replace all the project",
    },
    {
      "<leader>rv",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      desc = "Search and replace selected lines",
    },
    {
      "<leader>rc",
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
  },
  opts = {},
}

local persistence = {
  "folke/persistence.nvim",
  event = { "BufWritePre" },
  cmd = { "SelectSession" },
  init = function()
    vim.api.nvim_buf_create_user_command(0, "SelectSession", function()
      require("persistence").select()
    end, {})
  end,
  keys = {
    {
      "<leader>sS",
      function()
        require("persistence").load()
      end,
      mode = "n",
      desc = "load the session for the current directory",
    },
    {
      "<leader>ss",
      function()
        require("persistence").select()
      end,
      mode = "n",
      desc = "select a session to load",
    },
    {
      "<leader>sl",
      function()
        require("persistence").load({ last = true })
      end,
      mode = "n",
      desc = "load the last session",
    },
    {
      "<leader>sd",
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
    { "<c-f>", "<cmd>ToggleFloatTerm<cr>", desc = "Toggle float term" },
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

local aerial = {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>2", "<cmd>AerialToggle! right<cr>", desc = "Open Outilne Explorer" },
    { "{", "<cmd>AerialPrev<cr>", desc = "Aerial Previous item" },
    { "}", "<cmd>AerialNext<cr>", desc = "Aerial Next item" },
  },
  opts = {
    show_guides = true,
    backends = { "lsp", "markdown", "treesitter" },
    update_events = "TextChanged,InsertLeave",
    layout = {
      min_width = { 40, 0.2 },
      max_width = { 40, 0.2 },
    },
    lsp = {
      diagnostics_trigger_update = false,
      update_when_errors = true,
      update_delay = 300,
    },
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },
    filter_kind = {
      "Module",
      "Struct",
      "Interface",
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Method",
    },
  },
}

local yanky = {
  "gbprod/yanky.nvim",
  init = function()
    vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
    vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
  end,
  opts = {
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 200,
    },
  },
}

local surround = { "kylechui/nvim-surround", opts = {} }

local snippets = {
  "chrisgrieser/nvim-scissors",
  cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
  keys = {
    { "<leader>ps", "<cmd>ScissorsAddNewSnippet<cr>", desc = "Add new snippet", mode = { "n", "x" } },
    { "<leader>pe", "<cmd>ScissorsEditSnippet<cr>", desc = "Edit snippet", mode = { "n", "x" } },
  },
  opts = function()
    local nvim_config_path = vim.fn.stdpath("config")
    local snippets_path = nvim_config_path .. "/snippets"
    return {
      snippetDir = snippets_path,
    }
  end,
}

local lualine = {
  "nvim-lualine/lualine.nvim",
  opts = {
    theme = colorscheme,
  },
}

return {
  grug_far,
  moveline,
  wakatime,
  gx,
  gitsigns,
  persistence,
  term,
  aerial,
  yanky,
  surround,
  snippets,
  lualine,
}
