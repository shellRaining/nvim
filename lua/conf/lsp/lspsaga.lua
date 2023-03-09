-- https://github.com/j-hui/fidget.nvim
local api = require("utils.api")

local M = {
	requires = {
		"lspsaga",
	},
}

function M.before() end

function M.load()
	M.lspsaga.setup({
		symbol_in_winbar = {
			enable = false,
		},
		lightbulb = {
			enable = false,
		},
	})
end

function M.after()
	api.map.bulk_register({
		{
			mode = { "n" },
			lhs = "<leader>ca",
			rhs = "<cmd>Lspsaga code_action<CR>",
			options = { silent = true },
			description = "Show code action",
		},
		{
			mode = { "n" },
			lhs = "<leader>cn",
			rhs = "<cmd>Lspsaga rename<CR>",
			options = { silent = true },
			description = "Variable renaming",
		},
		{
			mode = { "n" },
			lhs = "<leader>cf",
			rhs = function()
				vim.lsp.buf.format({ async = true })
			end,
			options = { silent = true },
			description = "Format buffer",
		},
		{
			mode = { "n" },
			lhs = "gh",
			rhs = "<cmd>Lspsaga lsp_finder<CR>",
			options = { silent = true },
			description = "Show help information",
		},
		{
			mode = { "n" },
			lhs = "K",
			rhs = "<cmd>Lspsaga hover_doc<CR>",
			options = { silent = true },
			description = "check doc",
		},
		{
			mode = { "n" },
			lhs = "gd",
			rhs = "<cmd>Lspsaga peek_definition<CR>",
			options = { silent = true },
			description = "peek to definitions",
		},
		{
			mode = { "n" },
			lhs = "gD",
			rhs = "<cmd>Lspsaga goto_definition<CR>",
			options = { silent = true },
			description = "Go to type definitions",
		},
		{
			mode = { "n" },
			lhs = "gt",
			rhs = "<cmd>Lspsaga peek_type_definition<CR>",
			options = { silent = true },

			description = "Go to type definitions",
		},
		{
			mode = { "n" },
			lhs = "go",
			rhs = "<cmd>Lspsaga diagnostic_jump_prev<CR>",
			options = { silent = true },
			description = "Show Current Diagnostics",
		},
		{
			mode = { "n" },
			lhs = "gO",
			rhs = function()
				require("telescope.builtin").diagnostics()
			end,
			options = { silent = true },
			description = "Show Workspace Diagnostics",
		},
	})
end

return M
