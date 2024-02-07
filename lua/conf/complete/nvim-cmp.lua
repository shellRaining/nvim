local public = require("utils.public")
local options = require("core.options")
local aid_nvim_cmp = require("utils.aid.nvim-cmp")
local icons = public.get_icons_group("lsp_kind", false)

local M = {
    requires = {
        "cmp",
        "cmp.types",
        "luasnip",
        "copilot.suggestion",
        "nvim-autopairs.completion.cmp",
    },
    event = { "InsertEnter", "CmdlineEnter" },
}

function M.load()
    aid_nvim_cmp.receive_cmp(M.cmp, M.copilot_suggestion)

    M.cmp.setup({
        view = { entries = "custom" },
        experimental = { ghost_text = { hl_group = "CmpGhostText" } },
        -- Insert or Replace
        confirmation = { default_behavior = M.cmp.ConfirmBehavior.Insert },
        snippet = {
            expand = function(args)
                M.luasnip.lsp_expand(args.body)
            end,
        },
        -- define completion source
        sources = M.cmp.config.sources({
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
            { name = "fonts" },
            { name = "beancount", option = { account = "~/beancount/V2023/accounts.beancount" } },
        }),
        sorting = {
            priority_weight = 2,
            comparators = {
                M.cmp.config.compare.offset,
                M.cmp.config.compare.exact,
                M.cmp.config.compare.score,
                M.cmp.config.compare.recently_used,
                M.cmp.config.compare.locality,
                M.cmp.config.compare.kind,
                M.cmp.config.compare.length,
                M.cmp.config.compare.order,
            },
        },
        mapping = {
            ["<c-p>"] = aid_nvim_cmp.select_prev_item(),
            ["<c-n>"] = aid_nvim_cmp.select_next_item(),
            ["<c-b>"] = aid_nvim_cmp.scroll_docs(-5),
            ["<c-f>"] = aid_nvim_cmp.scroll_docs(5),
            ["<tab>"] = aid_nvim_cmp.confirm_select(),
            ["<c-l>"] = aid_nvim_cmp.confirm_copilot(),
            ["<C-Space>"] = aid_nvim_cmp.select_next_copilot_item(),
            ["<c-u>"] = aid_nvim_cmp.select_prev_n_item(5),
            ["<c-d>"] = aid_nvim_cmp.select_next_n_item(5),
            ["<c-k>"] = aid_nvim_cmp.toggle_complete_menu(),
        },
        formatting = {
            -- sort menu
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind = "<" .. vim_item.kind .. ">"
                local source = "(" .. entry.source.name .. ")"

                vim_item.kind = (" %s "):format(icons[vim_item.kind])
                vim_item.menu = ("%-10s %s"):format(kind, source:upper())

                return vim_item
            end,
        },
        window = not options.float_border and {}
            or {
                completion = M.cmp.config.window.bordered({
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
                    -- menu position offset
                    col_offset = -4,
                    -- content offset
                    side_padding = 0,
                    border = "single",
                }),
                documentation = M.cmp.config.window.bordered({
                    winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
                    border = "single",
                }),
            },
    })

    M.cmp.event:on("confirm_done", M.nvim_autopairs_completion_cmp.on_confirm_done())
end

function M.after()
    -- define completion in cmd mode
    M.cmp.setup.cmdline("/", {
        sources = {
            { name = "buffer" },
        },
    })

    M.cmp.setup.cmdline("?", {
        sources = {
            { name = "buffer" },
        },
    })

    M.cmp.setup.cmdline(":", {
        sources = M.cmp.config.sources({
            { name = "path" },
            { name = "cmdline" },
        }),
    })
end

return M
