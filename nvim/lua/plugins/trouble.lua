return {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons' ,
    cmd = 'Trouble',
	--keys = { { '<leader>t','<cmd>Trouble diagnostics toggle<cr>' } },
	keys = { { '<leader>t',function() require('trouble').toggle("diagnostics") end } },
}
