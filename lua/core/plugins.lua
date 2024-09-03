local aid_lazy = require("utils.aid.lazy")

local M = {}

M.theme = {
    { "folke/tokyonight.nvim" },
}

M.basic = {
    { "williamboman/mason.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },
}

M.lsp = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason-lspconfig.nvim" },
    { "folke/lazydev.nvim", ft = "lua" },
    { "Bilal2453/luvit-meta", lazy = true },
    { "nvimtools/none-ls.nvim", name = "null-ls" },
    { "ray-x/lsp_signature.nvim" },
}

M.complete = {
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "zbirenbaum/copilot.lua" },
    { "crispgm/cmp-beancount", ft = { "beancount" } },
}

M.find = {
    { "ibhagwan/fzf-lua" },
    { "folke/todo-comments.nvim" },
    { "folke/flash.nvim" },
}

M.language = {
    { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } },
}

M.tools = {
    { "CRAG666/code_runner.nvim" },
    { "willothy/moveline.nvim", build = "make" },
    { "wakatime/vim-wakatime", lazy = false },
    { "chrishrb/gx.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
    { "nmac427/guess-indent.nvim" },
    { "stevearc/profile.nvim" },
}

M.views = {
    { "akinsho/toggleterm.nvim" },
    -- { "stevearc/aerial.nvim" },
    { "folke/trouble.nvim" },
    { "nvimdev/dashboard-nvim", event = "VimEnter" },
    { "mikavilpas/yazi.nvim" },
}

M.editor = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "kylechui/nvim-surround", version = "*" },
    { "windwp/nvim-ts-autotag" },
    { "windwp/nvim-autopairs" },
    { "numToStr/Comment.nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "shellRaining/hlchunk.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } },
    -- { "echasnovski/mini.indentscope", version = "*" },
}

aid_lazy.entry(M)

return M
