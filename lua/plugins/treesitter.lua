local ensure_installed = {
  "bash",
  "c",
  "css",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "vue",
  "vimdoc",
  "yaml",
}

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang then
          return
        end
        pcall(vim.treesitter.start, ev.buf, lang)
      end,
    })
  end,
}

local autotag = {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    aliases = {
      ["wxml"] = "html",
    },
  },
}

local autopair = {
  "windwp/nvim-autopairs",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = { map_c_h = true, map_c_w = true },
}

local comment = { "numToStr/Comment.nvim", opts = {} }

local commentstring = {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("ts_context_commentstring").setup(opts)
    local utils = require("ts_context_commentstring.utils")
    local orig_is_active = utils.is_treesitter_active
    utils.is_treesitter_active = function(bufnr)
      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if not ok or parser == nil then
        return false
      end
      return orig_is_active(bufnr)
    end
  end,
}

return {
  treesitter,
  autotag,
  autopair,
  comment,
  commentstring,
}
