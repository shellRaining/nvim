local colorscheme = require("core.config").colorscheme

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
    -- fold mapping
    local function open_folds_in_visual()
      local start_l = vim.fn.line("v")
      local end_l = vim.fn.line(".")
      if start_l > end_l then
        start_l, end_l = end_l, start_l
      end
      for l = start_l, end_l do
        if vim.fn.foldclosed(l) ~= -1 then
          vim.cmd(l .. "foldopen!")
        end
      end
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    end
    vim.keymap.set("v", "zR", function()
      open_folds_in_visual()
    end, { desc = "open all fold" })
    return {
      fold_virt_text_handler = handler,
      provider_selector = function(bufnr, filetype, buftype)
        -- 禁用 grug-far 的折叠
        if filetype == "grug-far" then
          return ""
        end
        return { "treesitter", "indent" }
      end,
    }
  end,
}

local codesnap = {
  "mistricky/codesnap.nvim",
  tag = "v2.0.0-beta.17",
  cmd = {
    "CodeSnap",
    "CodeSnapSave",
  },
  opts = {
    watermark = {
      content = "",
      font_family = "Pacifico",
      color = "#ffffff",
    },
  },
}

return {
  wakatime,
  gx,
  persistence,
  yanky,
  surround,
  neogen,
  ufo,
  codesnap,
}
