require('lazy').setup({
    --Finders
    { 'nvim-telescope/telescope.nvim', dependencies = { {'nvim-lua/plenary.nvim'} } },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- Themes
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            require('tokyonight').setup({transparent = true})
            vim.cmd[[colorscheme tokyonight]]
        end,
    },
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true } },
    --'kyazdani42/nvim-web-devicons'



    --LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            {'simrat39/inlay-hints.nvim'},
        }
    },

    { 'windwp/nvim-autopairs' , config = function() require('nvim-autopairs').setup{} end },
    { 'folke/trouble.nvim' , dependencies = "nvim-tree/nvim-web-devicons" , config = function() require("trouble").setup {} end },
    { 'folke/todo-comments.nvim', dependencies = "nvim-lua/plenary.nvim" , config = function() require("todo-comments").setup {} end },

	{ 'goolord/alpha-nvim',  dependencies = { 'nvim-tree/nvim-web-devicons' } },

    {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
    return require "Link459.config.null-ls" end, },
    { 'ThePrimeagen/harpoon' },
})
