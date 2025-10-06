local signature = require("core.config").signature

local frontend_formatter = function()
  local root = vim.fs.root
  if root(0, "dprint.json") then
    return { "dprint" }
  elseif root(0, { ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js" }) then
    return { "prettierd", "prettier", stop_after_first = true }
  elseif root(0, { "eslint.config.js", "eslint.config.mjs" }) then
    return {}
  end
  return { "prettierd", "prettier", stop_after_first = true }
end
local json_formatter = vim.tbl_extend("force", { "fixjson" }, frontend_formatter())
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
      html = frontend_formatter,
      javascript = frontend_formatter,
      typescript = frontend_formatter,
      javascriptreact = frontend_formatter,
      typescriptreact = frontend_formatter,
      vue = frontend_formatter(),
      beancount = { "bean-format" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      bash = { "shfmt" },
      json = json_formatter,
      jsonc = json_formatter,
      json5 = json_formatter,
      markdown = { "prettierd", "prettier", stop_after_first = true },
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
  opts = {
    ui = {
      border = "double",
    },
  },
}

local mason_lspconfig = {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    -- 这里的包名应该是 mason 后边的名字，而非主名称
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "clangd",
      "cssls",
      "jsonls", -- json, jsonc, json5, typescript, javascript
      "yamlls",
      "html",
      "emmet_language_server",
      "vue_ls",
      "vimls",
      "bashls",
      "vtsls",
      "pyright",
      "beancount",
      "tailwindcss",
      "eslint",
    },
  },
}

local lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
    local vue_language_server_path = ""
    local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
    if mason_registry_ok then
      local ok, vue_language_server_pkg = pcall(mason_registry.get_package, mason_registry, "vue-language-server")
      if ok then
        vue_language_server_path = vue_language_server_pkg:get_install_path() .. "/node_modules/@vue/language-server"
      end
    end
    if vue_language_server_path == "" then
      vue_language_server_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")
    end
    local vue_plugin = {
      name = "@vue/typescript-plugin",
      location = vue_language_server_path,
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptDiagnostics = true,
    }
    local vtsls_config = {
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = { vue_plugin },
          },
        },
      },
      init_options = {
        plugins = { vue_plugin },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    }
    local vue_ls_config = {}
    vim.lsp.config("vtsls", vtsls_config)
    vim.lsp.config("vue_ls", vue_ls_config)
    vim.lsp.enable({ "vtsls", "vue_ls" })

    vim.lsp.config("bashls", {
      filetypes = { "bash", "csh", "ksh", "sh", "zsh" },
    })
    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.config("beancount", {
      init_options = {
        journal_file = "~/Nextcloud/beancount/src/main.beancount",
      },
    })
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

local schema_store = { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } }

return {
  mason,
  mason_lspconfig,
  conform,
  lazydev,
  lspconfig,
  lsp_signature,
  schema_store,
}
