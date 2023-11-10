return {
    'https://github.com/mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
        {'<leader>u','<cmd>UndotreeToggle<cr>'}
    }
    --config = function()
		--vim.keymap.set('n','<leader>u',vim.cmd.UndotreeToggle)
    --end,
}
