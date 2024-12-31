local cmp = require("core.config").cmp

local cmpConfig = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")

    local function confirm()
      return cmp.mapping(cmp.mapping.confirm(), { "i", "s", "c" })
    end

    local function confirm_select()
      return cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "s", "c" })
    end

    local function select_next_copilot_item()
      return cmp.mapping(function(fallback)
        if copilot_suggestion.is_visible() then
          copilot_suggestion.next()
        else
          fallback()
        end
      end, { "i" })
    end

    local function select_prev_item()
      return cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" })
    end

    local function select_next_item()
      return cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" })
    end

    local function scroll_docs(n)
      return cmp.mapping(cmp.mapping.scroll_docs(n), { "i", "s", "c" })
    end

    local function select_prev_n_item(n)
      return cmp.mapping(function(fallback)
        if cmp.visible() then
          for _ = 1, n, 1 do
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          end
        else
          fallback()
        end
      end, { "i", "s", "c" })
    end

    local function select_next_n_item(n)
      return cmp.mapping(function(fallback)
        if cmp.visible() then
          for _ = 1, n, 1 do
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
        else
          fallback()
        end
      end, { "i", "s", "c" })
    end

    local function toggle_complete_menu()
      return cmp.mapping(function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end, { "i", "s", "c" })
    end

    local function backspace()
      return cmp.mapping(function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, true, true), "x")
        vim.fn.feedkeys("i", "n")
      end, { "s" })
    end

    cmp.setup({
      view = { entries = "custom" },
      experimental = { ghost_text = { hl_group = "CmpGhostText" } },
      confirmation = { default_behavior = cmp.ConfirmBehavior.Insert },
      mapping = {
        ["<c-p>"] = select_prev_item(),
        ["<c-n>"] = select_next_item(),
        ["<c-b>"] = scroll_docs(-5),
        ["<c-f>"] = scroll_docs(5),
        ["<tab>"] = confirm_select(),
        ["<C-Space>"] = select_next_copilot_item(),
        ["<c-u>"] = select_prev_n_item(5),
        ["<c-d>"] = select_next_n_item(5),
        ["<c-k>"] = toggle_complete_menu(),
        ["<bs>"] = backspace(),
      },
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "fonts" },
      }),
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}

local blinkConfig = {
  "saghen/blink.cmp",
  version = "*",
  event = { "InsertEnter", "CmdlineEnter" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        border = "single",
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = true,
      },
    },
  },
  opts_extend = { "sources.default" },
}

local cmp2Config = {
  cmp = cmpConfig,
  blink = blinkConfig,
}

return {
  cmp2Config[cmp],
}
