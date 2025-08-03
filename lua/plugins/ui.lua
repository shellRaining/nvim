local colorscheme = require("core.config").colorscheme

local overseer = {
  "stevearc/overseer.nvim",
  opts = {},
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

local lualine = {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local noice = require("noice")
    local function fg(name)
      local hl = vim.api.nvim_get_hl(0, { name = name })
      return hl and hl.fg and { fg = string.format("#%06x", hl.fg) } or nil
    end
    return {
      theme = colorscheme,
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = {
          {
            function()
              return noice.api.status.mode.get()
            end,
            cond = noice.api.status.mode.has,
            color = fg("Constant"),
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    }
  end,
}

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
      mode = "v",
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
    return {
      -- 确保搜索结果不会被折叠
      folding = {
        enabled = false,
      },
    }
  end,
}

local term = {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle term" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle term" },
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
    link_tree_to_folds = false,
  },
}

local yazi = {
  "mikavilpas/yazi.nvim",
  lazy = true,
  keys = {
    {
      "<leader>1",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
  },
}

return {
  overseer,
  gitsigns,
  lualine,
  grug_far,
  term,
  aerial,
  yazi,
}
