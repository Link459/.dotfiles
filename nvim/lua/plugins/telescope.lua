return {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            pickers = {
                find_files = {
                    hidden = true,
                }
            },

            defaults = {
        		file_ignore_patterns = {
               		"./.git",
                	".git",
                    "./ext",
                    "./.cache",
                    ".cache",
            	}
        	}
        }
        local builtin = require('telescope.builtin')
        vim.keymap.set('n','<leader>sf',builtin.find_files)
        vim.keymap.set('n','<leader>sg',builtin.git_files)
        vim.keymap.set('n','<leader>ss',builtin.live_grep)
        end,
}
