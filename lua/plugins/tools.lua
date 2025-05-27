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

local lualine = {
  "nvim-lualine/lualine.nvim",
  opts = {
    theme = colorscheme,
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
    },
  },
}

---@param increment boolean
---@param g? boolean
local function dial_module(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end
local dial = {
  "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", function() return dial_module(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "<C-x>", function() return dial_module(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
    { "g<C-a>", function() return dial_module(true, true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    { "g<C-x>", function() return dial_module(false, true) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
  },

  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      },
      groups = {
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
        },
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        css = {
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver, -- versioning (v1.1.2)
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      },
    }
  end,
  config = function(_, opts)
    for name, group in pairs(opts.groups) do
      if name ~= "default" then
        vim.list_extend(group, opts.groups.default)
      end
    end
    require("dial.config").augends:register_group(opts.groups)
    vim.g.dials_by_ft = opts.dials_by_ft
  end,
}

local neogen = {
  "danymat/neogen",
  keys = {
    { "<leader>cc", "<cmd>lua require('neogen').generate()<CR>", desc = "Generate doc comments" },
  },
  config = true,
}

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰁂 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end
local ufo = {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = function()
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    return { fold_virt_text_handler = handler }
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
  aerial,
  yanky,
  surround,
  lualine,
  dial,
  neogen,
  ufo,
}
