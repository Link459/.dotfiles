return {
        'folke/tokyonight.nvim',
        --lazy = true, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            require('tokyonight').setup({transparent = true})
            vim.cmd[[colorscheme tokyonight]]
        end,
    }

