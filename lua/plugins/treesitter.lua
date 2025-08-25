local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
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
      },
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
      },
      -- incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          node_incremental = "<cr>",
          node_decremental = "<bs>",
          scope_incremental = false,
        },
      },
    })
  end,
}

local autotag = {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    opts = {
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </
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

local commentstring = { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy", opts = {} }

return {
  treesitter,
  autotag,
  autopair,
  comment,
  commentstring,
}
