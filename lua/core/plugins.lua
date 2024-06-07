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
    { "willothy/flatten.nvim", lazy = false, priority = 1001 },
}

M.lsp = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },
    { "folke/lazydev.nvim", ft = "lua" },
    { "Bilal2453/luvit-meta", lazy = true },
    { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },
    { "nvimtools/none-ls.nvim", name = "null-ls" },
    { "luckasRanarison/clear-action.nvim" },
    -- { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } },
    { "onsails/lspkind-nvim" },
    -- { "SmiteshP/nvim-navic", lazy = true },
    -- { "nvimdev/lspsaga.nvim", ft = { "vue" } },
}

-- M.dap = {
--     { "mfussenegger/nvim-dap" },
--     { "jay-babu/mason-nvim-dap.nvim" },
--     { "theHamsta/nvim-dap-virtual-text", opts = {} },
--     { "rcarriga/nvim-dap-ui" },
--     { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },
-- }

M.complete = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "saadparwaiz1/cmp_luasnip" },
            -- { "amarakon/nvim-cmp-fonts", ft = { "yaml", "json", "toml" } },
        },
    },
    { "L3MON4D3/LuaSnip" },
    { "zbirenbaum/copilot.lua" },
    { "crispgm/cmp-beancount", ft = { "beancount" } },
}

M.find = {
    { "folke/todo-comments.nvim" },
    { "folke/flash.nvim" },
    { "nvim-telescope/telescope.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } },
    { "ahmedkhalf/project.nvim" },
}

M.language = {
    { "davidgranstrom/nvim-markdown-preview", ft = { "markdown" }, cmd = "MarkdownPreview" },
    { "b0o/schemastore.nvim", ft = { "json", "json5", "jsonc" } },
    { "hotoo/pangu.vim", ft = { "markdown" } },
}

M.tools = {
    { "lewis6991/gitsigns.nvim" },
    { "folke/which-key.nvim" },
    { "CRAG666/code_runner.nvim" },
    { "barrett-ruth/live-server.nvim", build = "npm install -g live-server", config = true, cmd = "LiveServerStart" },
    { "willothy/moveline.nvim", build = "make" },
    { "uga-rosa/translate.nvim" },
    { "ellisonleao/carbon-now.nvim" },
    { "AckslD/nvim-neoclip.lua" },
    { "wakatime/vim-wakatime" },
    { "chrishrb/gx.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = true },
    { "nmac427/guess-indent.nvim" },
    { "smjonas/live-command.nvim" },
    { "stevearc/profile.nvim" },
}

M.views = {
    { "nvimdev/dashboard-nvim" },
    { "akinsho/toggleterm.nvim" },
    { "akinsho/bufferline.nvim", event = { "VeryLazy" } },
    { "nvim-lualine/lualine.nvim" },
    { "stevearc/aerial.nvim" },
    -- { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },
    { "nvim-tree/nvim-tree.lua" },
    { "kelly-lin/ranger.nvim" },
    { "folke/trouble.nvim" },
    -- { "nvim-zh/colorful-winsep.nvim" },
    { "folke/zen-mode.nvim", cmd = { "ZenMode" } },
}

M.editor = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "kylechui/nvim-surround", version = "*" },
    { "windwp/nvim-ts-autotag" },
    { "RRethy/vim-illuminate" },
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    { "windwp/nvim-autopairs" },
    { "numToStr/Comment.nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "echasnovski/mini.bufremove", name = "miniBufremove" },
    -- { "shellRaining/nvim_md_HFfont", ft = { "markdown" } },
    { "shellRaining/hlchunk.nvim", dependencies = { { "nvim-lua/plenary.nvim" } } },
    -- { "Mr-LLLLL/cool-chunk.nvim" },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = { "UIEnter" },
    --     dependencies = {
    --         "TheGLander/indent-rainbowline.nvim",
    --     },
    -- },
    -- { "echasnovski/mini.indentscope", version = "*" },
    -- { "nvimdev/indentmini.nvim" },
}

aid_lazy.entry(M)

return M
