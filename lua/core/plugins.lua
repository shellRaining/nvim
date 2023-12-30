-- https://github.com/folke/lazy.nvim

local aid_lazy = require("utils.aid.lazy")

local M = {}

M.theme = {
    { "folke/tokyonight.nvim" },
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- { "oxfist/night-owl.nvim", },
}

M.basic = {
    { "folke/noice.nvim" },
    { "williamboman/mason.nvim" },
    { "rcarriga/nvim-notify" },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
    { "kkharji/sqlite.lua", module = "sqlite" },
    { "stevearc/dressing.nvim", opts = {} },
}

M.lsp = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim", lazy = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },
    { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },
    -- { "jose-elias-alvarez/null-ls.nvim" },
    { "nvimtools/none-ls.nvim", name = "null-ls" },
    { "luckasRanarison/clear-action.nvim" },
    { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } },
    -- { "SmiteshP/nvim-navic", lazy = true },
}

M.dap = {
    { "mfussenegger/nvim-dap" },
    { "jay-babu/mason-nvim-dap.nvim" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "rcarriga/nvim-dap-ui" },
    { "mxsdev/nvim-dap-vscode-js" },
}

M.complete = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
    { "L3MON4D3/LuaSnip" },
    { "zbirenbaum/copilot.lua" },
}

M.find = {
    { "folke/todo-comments.nvim" },
    { "folke/flash.nvim" },
    { "nvim-telescope/telescope.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } },
    { "ahmedkhalf/project.nvim" },
    { "ThePrimeagen/harpoon", branch = "harpoon2" },
}

M.language = {
    { "davidgranstrom/nvim-markdown-preview", ft = { "markdown" } },
    { "b0o/schemastore.nvim" },
    -- { "ray-x/web-tools.nvim" },
}

M.tools = {
    { "lewis6991/gitsigns.nvim" },
    { "folke/which-key.nvim" },
    { "CRAG666/code_runner.nvim" },
    { "barrett-ruth/live-server.nvim", build = "npm install -g live-server", config = true },
    { "willothy/moveline.nvim", build = "make" },
    { "uga-rosa/translate.nvim" },
    { "ellisonleao/carbon-now.nvim" },
    { "jackMort/ChatGPT.nvim" },
    { "AckslD/nvim-neoclip.lua" },
    { "ziontee113/icon-picker.nvim" },
    { "wakatime/vim-wakatime" },
    { "chrishrb/gx.nvim" },
}

M.views = {
    { "nvimdev/dashboard-nvim" },
    { "akinsho/toggleterm.nvim" },
    { "akinsho/bufferline.nvim", event = { "VeryLazy" } },
    { "nvim-lualine/lualine.nvim" },
    { "stevearc/aerial.nvim" },
    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },
    { "folke/trouble.nvim" },
    { "nvim-zh/colorful-winsep.nvim" },
    { "folke/zen-mode.nvim", opts = {} },
    -- { "Pocco81/true-zen.nvim" },
}

M.editor = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
    { "chrisgrieser/nvim-various-textobjs" },
    { "kylechui/nvim-surround", version = "*" },
    { "windwp/nvim-ts-autotag" },
    { "RRethy/vim-illuminate" },
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    { "windwp/nvim-autopairs" },
    { "numToStr/Comment.nvim" },
    { "echasnovski/mini.bufremove", name = "miniBufremove" },
    { "shellRaining/hlchunk.nvim" },
    { "shellRaining/nvim_md_HFfont", ft = { "markdown" } },
    -- {
    --     "echasnovski/mini.indentscope",
    --     event = { "UIEnter" },
    --     config = function()
    --         require("mini.indentscope").setup()
    --     end,
    -- },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = { "UIEnter" },
    -- },
}

aid_lazy.entry(M)

return M
