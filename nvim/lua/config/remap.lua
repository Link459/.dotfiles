--[[
local ui = require('harpoon.ui')
local mark = require('harpoon.mark')

vim.keymap.set('n','<leader>ha',mark.add_file)
vim.keymap.set('n','<leader>hs',ui.toggle_quick_menu) 

vim.keymap.set('n','<leader>h1',function() ui.nav_file(1) end)
vim.keymap.set('n','<leader>h2',function() ui.nav_file(2) end)
vim.keymap.set('n','<leader>h3',function() ui.nav_file(3) end)
vim.keymap.set('n','<leader>h4',function() ui.nav_file(4) end)
vim.keymap.set('n','<leader>h5',function() ui.nav_file(5) end)
vim.keymap.set('n','<leader>h6',function() ui.nav_file(6) end)
vim.keymap.set('n','<leader>h7',function() ui.nav_file(7) end)
vim.keymap.set('n','<leader>h8',function() ui.nav_file(8) end)
]]--
vim.keymap.set('n','<leader>sn',function() vim.cmd('LspClangdSwitchSourceHeader')end)

vim.keymap.set('i', '<Tab>', '<C-V><Tab>', { noremap = true })

vim.keymap.set({'n', 'v'}, '<leader>y', [['+y]])
vim.keymap.set('n', '<leader>Y', [['+Y]])


