local find = require("core.config").find

local M = {
  {
    key = "<leader>ff",
    desc = "Find Files",
    tools = {
      telescope = "<cmd>Telescope find_files<cr>",
      ["fzf-lua"] = "<cmd>FzfLua files<cr>",
    },
  },
   {
    key = "<leader>/",
    desc = "Find Files",
    tools = {
      telescope = "<cmd>Telescope live_grep<cr>",
      ["fzf-lua"] = "<cmd>FzfLua live_grep<cr>",
    },
  },
  {
    key = "<leader><space>",
    desc = "Find Buffers",
    tools = {
      telescope = "<cmd>Telescope buffers<cr>",
      ["fzf-lua"] = "<cmd>FzfLua buffers<cr>",
    },
  },
   {
    key = "<leader>fo",
    desc = "Find Old Files",
    tools = {
      telescope = "<cmd>Telescope oldfiles<cr>",
      ["fzf-lua"] = "<cmd>FzfLua oldfiles<cr>",
    },
  },
 {
    key = "<leader>fg",
    desc = "Find Git Commits",
    tools = {
      telescope = "<cmd>Telescope git_commits<CR>",
      ["fzf-lua"] = "<cmd>FzfLua git_commits<CR>",
    },
  },
   {
    key = "<leader>fh",
    desc = "Find Help Tags",
    tools = {
      telescope = "<cmd>Telescope help_tags<cr>",
      ["fzf-lua"] = "<cmd>FzfLua help_tags<cr>",
    },
  },
  {
    key = "<leader>fk",
    desc = "Find Keymaps",
    tools = {
      telescope = "<cmd>Telescope keymaps<cr>",
      ["fzf-lua"] = "<cmd>FzfLua keymaps<cr>",
    },
  },
  {
    key = "<leader>fs",
    desc = "Find Lsp Document Symbols",
    tools = {
      telescope = "<cmd>Telescope lsp_document_symbols<cr>",
      ["fzf-lua"] = "<cmd>FzfLua lsp_document_symbols<cr>",
    },
  },
  {
    key = "<leader>fu",
    desc = "Find Resume",
    tools = {
      telescope = "<cmd>Telescope resume<cr>",
      ["fzf-lua"] = "<cmd>FzfLua resume<cr>",
    },
  },
  {
    key = "<leader>fc",
    desc = "Find Colorscheme",
    tools = {
      telescope = "<cmd>Telescope colorscheme<cr>",
      ["fzf-lua"] = "<cmd>FzfLua colorschemes<cr>",
    },
  },
}

local keymaps = {}
for i, v in ipairs(M) do
  keymaps[i] = { v.key, v.tools[find], desc = v.desc }
end

local fzf_config = {
  "ibhagwan/fzf-lua",
  cond = find == "fzf-lua",
  cmd = "FzfLua",
  keys = keymaps,
  opts = function()
    local actions = require("trouble.sources.fzf").actions
    vim.cmd("FzfLua register_ui_select")
    return {
      winopts = {
        height = 0.5,
        width = 0.80,
        preview = {
          layout = "vertical",
          vertical = "up:70%",
        },
      },
      actions = {
        files = {
          true,
          ["ctrl-t"] = actions.open,
          ["alt-q"] = actions.file_sel_to_qf,
        },
      },
    }
  end,
}

local telescope_config = {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cond = find == "telescope",
  cmd = "Telescope",
  keys = keymaps,
  opts = function()
    local actions = require("telescope.actions")
    local trouble = require("trouble.sources.telescope")
    return {
      defaults = {
        file_ignore_patterns = { "node_modules" },
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = trouble.open,
            ["alt-q"] = actions.send_selected_to_qf,
          },
          n = {
            ["q"] = actions.close,
            ["<c-t>"] = trouble.open,
          },
        },
      },
      pickers = {
        buffers = {
          previewer = false,
          theme = "dropdown",
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            },
            n = {
              ["dd"] = "delete_buffer",
            },
          },
        },
      },
    }
  end,
}

return {
  fzf_config,
  telescope_config,
}
