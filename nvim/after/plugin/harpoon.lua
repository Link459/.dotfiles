local ui = require('harpoon.ui')
local mark = require('harpoon.mark')

vim.keymap.set('n','<leader>h',mark.add_file)
vim.keymap.set('n','<leader>m',ui.toggle_quick_menu) 

vim.keymap.set('n','<leader>q',function() ui.nav_file(1) end)
vim.keymap.set('n','<leader>w',function() ui.nav_file(2) end)
vim.keymap.set('n','<leader>e',function() ui.nav_file(3) end)
vim.keymap.set('n','<leader>r',function() ui.nav_file(4) end)
