return {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n','<leader>sf',builtin.find_files)
        vim.keymap.set('n','<leader>sg',builtin.git_files)
        vim.keymap.set('n','<leader>ss',builtin.live_grep)
        end,
}
