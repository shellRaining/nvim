local find = require("core.config").find

local M = {
  findFiles = {
    key = "<leader>ff",
    desc = "Find Files",
    tools = {
      telescope = "<cmd>Telescope find_files<cr>",
      ["fzf-lua"] = "<cmd>FzfLua files<cr>",
    },
  },
  findGrepGlob = {
    key = "<leader>/",
    desc = "Find Files",
    tools = {
      telescope = "<cmd>Telescope live_grep<cr>",
      ["fzf-lua"] = "<cmd>FzfLua live_grep_glob<cr>",
    },
  },
  findBuffers = {
    key = "<leader><space>",
    desc = "Find Buffers",
    tools = {
      telescope = "<cmd>Telescope buffers<cr>",
      ["fzf-lua"] = "<cmd>FzfLua buffers<cr>",
    },
  },
  findOldFiles = {
    key = "<leader>fo",
    desc = "Find Old Files",
    tools = {
      telescope = "<cmd>Telescope oldfiles<cr>",
      ["fzf-lua"] = "<cmd>FzfLua oldfiles<cr>",
    },
  },
  findGitCommits = {
    key = "<leader>fg",
    desc = "Find Git Commits",
    tools = {
      telescope = "<cmd>Telescope git_commits<CR>",
      ["fzf-lua"] = "<cmd>FzfLua git_commits<CR>",
    },
  },
  findHelpTags = {
    key = "<leader>fh",
    desc = "Find Help Tags",
    tools = {
      telescope = "<cmd>Telescope help_tags<cr>",
      ["fzf-lua"] = "<cmd>FzfLua help_tags<cr>",
    },
  },
  findKeymaps = {
    key = "<leader>fk",
    desc = "Find Keymaps",
    tools = {
      telescope = "<cmd>Telescope keymaps<cr>",
      ["fzf-lua"] = "<cmd>FzfLua keymaps<cr>",
    },
  },
  findLspDocumentSymbols = {
    key = "<leader>fs",
    desc = "Find Lsp Document Symbols",
    tools = {
      telescope = "<cmd>Telescope lsp_document_symbols<cr>",
      ["fzf-lua"] = "<cmd>FzfLua lsp_document_symbols<cr>",
    },
  },
  findResume = {
    key = "<leader>fu",
    desc = "Find Resume",
    tools = {
      telescope = "<cmd>Telescope resume<cr>",
      ["fzf-lua"] = "<cmd>FzfLua resume<cr>",
    },
  },
  findColorscheme = {
    key = "<leader>fc",
    desc = "Find Colorscheme",
    tools = {
      telescope = "<cmd>Telescope colorscheme<cr>",
      ["fzf-lua"] = "<cmd>FzfLua colorschemes<cr>",
    },
  },
}

local keymaps = {}
for _, v in pairs(M) do
  keymaps[#keymaps + 1] = { v.key, v.tools[find], desc = v.desc }
end

local fzfConfig = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = keymaps,
  config = function()
    local actions = require("trouble.sources.fzf").actions
    require("fzf-lua").setup({
      winopts = {
        height = 0.5,
        width = 0.80,
      },
      actions = {
        files = {
          true,
          ["ctrl-t"] = actions.open,
        },
      },
    })
  end,
}

local telescopeConfig = {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = keymaps,
  config = function()
    local actions = require("telescope.actions")
    local trouble = require("trouble.sources.telescope")
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "node_modules" },
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = trouble.open,
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
    })
  end,
}

local find2Config = {
  ["fzf-lua"] = fzfConfig,
  telescope = telescopeConfig,
}

return {
  find2Config[find],
}
