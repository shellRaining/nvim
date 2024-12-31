local lsp_tools = require("core.config").lsp_tools

local conform = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = { timeout_ms = 500 },
  },
}

local lazydev = {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

local mason = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    max_concurrent_installers = 10,
    ui = {
      border = "double",
    },
  },
}

local ensure_installed = {
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "cssls",
  "biome", -- json, jsonc, json5, typescript, javascript
  "yamlls",
  "html",
  "emmet_language_server",
  "volar",
  "vimls",
  "bashls",
  "ts_ls",
  "pyright",
}

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = ensure_installed,
  },
}

local cmd_groups = {
  definitions = {
    native = vim.lsp.buf.definition,
    telescope = "<cmd>Telescope lsp_definitions<cr>",
    trouble = "<cmd>Trouble lsp_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>",
  },
  implementations = {
    native = vim.lsp.buf.implementation,
    telescope = "<cmd>Telescope lsp_implementations<cr>",
    trouble = "<cmd>Trouble lsp_implementations<cr>",
    fzf = "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
  },
  references = {
    native = vim.lsp.buf.references,
    telescope = "<cmd>Telescope lsp_references<cr>",
    trouble = "<cmd>Trouble lsp_references<cr>",
    fzf = "<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
  },
  type_definitions = {
    native = vim.lsp.buf.type_definition,
    telescope = "<cmd>Telescope lsp_type_definitions<cr>",
    trouble = "<cmd>Trouble lsp_type_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
  },
  code_actions = {
    native = vim.lsp.buf.code_action,
    telescope = "<cmd>Telescope lsp_code_actions<cr>",
    trouble = vim.lsp.buf.code_action, -- not have this cmd
    fzf = "<cmd>FzfLua lsp_code_actions<cr>",
  },
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    { "gd", cmd_groups.definitions[lsp_tools], desc = "Lsp Definitions" },
    { "gi", cmd_groups.implementations[lsp_tools], desc = "Lsp Implementations" },
    { "gr", cmd_groups.references[lsp_tools], desc = "Lsp References" },
    { "gt", cmd_groups.type_definitions[lsp_tools], desc = "Lsp Type Definitions" },
    { "ga", cmd_groups.code_actions[lsp_tools], desc = "Lsp Code Actions" },
    { "<leader>cn", vim.lsp.buf.rename, desc = "Lsp Rename" },
    {
      "<F8>",
      function()
        vim.diagnostic.goto_next({ float = false })
      end,
      desc = "Lsp Next Diagnostic",
    },
    {
      "<S-F8>",
      function()
        vim.diagnostic.goto_prev({ float = false })
      end,
      desc = "Lsp Previous Diagnostic",
    },
  },
  dependencies = {
    mason,
    mason_lspconfig,
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "single",
      title = "hover",
    })

    local server_config = {
      luals = require("plugins.lsp_servers.luals"),
      volar = require("plugins.lsp_servers.volar"),
      ts_ls = require("plugins.lsp_servers.ts_ls"),
    }

    for _, server in ipairs(ensure_installed) do
      local final_config = server_config[server] or {}
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {}
      )

      final_config.on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.semanticTokensProvider = nil
      end
      final_config.capabilities = capabilities
      lspconfig[server].setup(final_config)
    end
  end,
}

local none_ls = {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = function()
    local null_ls = require("null-ls")
    return {
      border = "double",
      sources = {
        null_ls.builtins.diagnostics.markdownlint,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "css",
            "scss",
            "less",
            "html",
            "yaml",
            "graphql",
            "handlebars",
            "json",
            "json5",
            "jsonc",
            "wxss",
            "wxml",
            "markdown",
          },
        }),
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.formatting.bean_format,
      },
    }
  end,
}

local lsp_signature = {
  "ray-x/lsp_signature.nvim",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    hint_enable = false,
    toggle_key = "<C-y>",
  },
}
return {
  conform,
  lazydev,
  lspconfig,
  none_ls,
  lsp_signature,
}
