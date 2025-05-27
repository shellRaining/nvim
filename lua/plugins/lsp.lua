local lsp_tools = require("core.config").lsp_tools
local signature = require("core.config").signature

local frontend_formatter = function()
  local root = vim.fs.root
  if root(0, "dprint.json") then
    return { "dprint" }
  elseif root(0, { ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js" }) then
    return { "prettierd", "prettier", stop_after_first = true }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end
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
      c = { "clang-format" },
      java = { "google-java-format" },
      lua = { "stylua" },
      python = { "black" },
      javascript = frontend_formatter,
      typescript = frontend_formatter,
      javascriptreact = frontend_formatter,
      typescriptreact = frontend_formatter,
      beancount = { "bean-format" },
      sh = { "shfmt" },
      json = vim.tbl_extend("force", { "fixjson" }, frontend_formatter()),
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function()
      local auto_format_ft = {
        json = true,
        json5 = true,
        jsonc = true,
      }
      local current_ft = vim.bo.filetype
      if auto_format_ft[current_ft] then
        return {
          timeout_ms = 500,
        }
      else
        return false
      end
    end,
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
  version = "1.x",
  opts = {
    max_concurrent_installers = 10,
    ui = {
      border = "double",
    },
  },
}

-- 这里的包名应该是 mason 后边的名字，而非主名称
local ensure_installed = {
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "cssls",
  "jsonls", -- json, jsonc, json5, typescript, javascript
  "yamlls",
  "html",
  "emmet_language_server",
  "volar",
  "vimls",
  "bashls",
  "ts_ls",
  "pyright",
  "beancount",
  "eslint",
}

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  version = "1.x",
  opts = {
    ensure_installed = ensure_installed,
  },
}

local cmd_groups = {
  definitions = {
    native = vim.lsp.buf.definition,
    telescope = "<cmd>Telescope lsp_definitions<cr>",
    trouble = "<cmd>Trouble lsp_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_definitions ignore_current_line=true<cr>",
  },
  implementations = {
    native = vim.lsp.buf.implementation,
    telescope = "<cmd>Telescope lsp_implementations<cr>",
    trouble = "<cmd>Trouble lsp_implementations<cr>",
    fzf = "<cmd>FzfLua lsp_implementations ignore_current_line=true<cr>",
  },
  references = {
    native = vim.lsp.buf.references,
    telescope = "<cmd>Telescope lsp_references<cr>",
    trouble = "<cmd>Trouble lsp_references<cr>",
    fzf = "<cmd>FzfLua lsp_references ignore_current_line=true<cr>",
  },
  type_definitions = {
    native = vim.lsp.buf.type_definition,
    telescope = "<cmd>Telescope lsp_type_definitions<cr>",
    trouble = "<cmd>Trouble lsp_type_definitions<cr>",
    fzf = "<cmd>FzfLua lsp_typedefs ignore_current_line=true<cr>",
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
        vim.diagnostic.jump({ count = 1, float = false })
      end,
      desc = "Lsp Next Diagnostic",
    },
    {
      "<S-F8>",
      function()
        vim.diagnostic.jump({ count = -1, float = false })
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
      jsonls = require("plugins.lsp_servers.jsonls"),
      beancount = require("plugins.lsp_servers.beancount_language_server"),
      bashls = require("plugins.lsp_servers.bashls"),
      eslint = require("plugins.lsp_servers.eslint"),
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
      final_config.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
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
      },
    }
  end,
}

local lsp_signature = {
  "ray-x/lsp_signature.nvim",
  cond = signature == "lsp_signature",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    hint_enable = false,
    toggle_key = "<C-y>",
  },
}

local fidget = {
  "j-hui/fidget.nvim",
  opts = {},
}

local schema_store = { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } }

return {
  conform,
  lazydev,
  lspconfig,
  none_ls,
  lsp_signature,
  fidget,
  schema_store,
}
