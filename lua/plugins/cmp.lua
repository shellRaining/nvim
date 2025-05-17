local cmp_tools = require("core.config").cmp
local signature = require("core.config").signature

local cmp_config = {
  "hrsh7th/nvim-cmp",
  cond = cmp_tools == "cmp",
  dependencies = {
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local cmp = require("cmp")

    local function confirm_select()
      return cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "s", "c" })
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
        ["<c-k>"] = toggle_complete_menu(),
        ["<bs>"] = backspace(),
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = cmp.config.sources({
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

local blink_config = {
  "saghen/blink.cmp",
  version = "*",
  cond = cmp_tools == "blink",
  event = { "InsertEnter", "CmdlineEnter" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = {
        function(blink_cmp)
          if blink_cmp.is_visible() then
            blink_cmp.hide()
          else
            blink_cmp.show()
          end
        end,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
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
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                return ctx.label .. ctx.label_detail
              end,
            },
            label_description = {
              width = { max = 30 },
              text = function(ctx)
                return ctx.label_description
              end,
              highlight = "BlinkCmpLabelDescription",
            },

            kind = {
              ellipsis = false,
              width = { fill = true },
              text = function(ctx)
                return ctx.kind:sub(1, 4)
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
      ghost_text = {
        enabled = false,
      },
    },
    -- Experimental signature help support
    signature = {
      enabled = signature == "blink",
      trigger = {
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
        -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
        show_on_insert_on_trigger_character = true,
      },
      window = {
        min_width = 30,
        max_width = 100,
        max_height = 10,
        border = "single",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
        -- Which directions to show the window,
        -- falling back to the next direction when there's not enough space,
        -- or another window is in the way
        direction_priority = { "n", "s" },
        -- Disable if you run into performance issues
        treesitter_highlighting = true,
      },
    },
    cmdline = {
      keymap = {
        ["<Tab>"] = { "accept" },
      },
      completion = { menu = { auto_show = true } },
    },
  },
  opts_extend = { "sources.default" },
}

return {
  cmp_config,
  blink_config,
}
