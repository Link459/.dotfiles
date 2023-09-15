local builtin = require('telescope.builtin')
local ui = require('harpoon.ui')
local mark = require('harpoon.mark')

vim.keymap.set('n','<leader>h',mark.add_file)
vim.keymap.set('n','<leader>m',ui.toggle_quick_menu) 

vim.keymap.set('n','<leader>a',function() ui.nav_file(1) end)
vim.keymap.set('n','<leader>s',function() ui.nav_file(2) end)
vim.keymap.set('n','<leader>d',function() ui.nav_file(3) end)
vim.keymap.set('n','<leader>f',function() ui.nav_file(4) end)

vim.keymap.set('i', '<Tab>', '<C-V><Tab>', { noremap = true })

--vim.keymap.set("<C-u>","<C-u>zz")
--vim.keymap.set("<C-d>","<C-d>zz") 

--LSP
vim.keymap.set("n","<leader>t","<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--vim.keymap.set("n", "<leader>k", "<cmd>bnext<CR>")
--vim.keymap.set("n", "<leader>j", "<cmd>bprev<CR>")

vim.keymap.set('n','<leader>sf',builtin.find_files)
vim.keymap.set('n','<leader>sg',builtin.git_files)
vim.keymap.set('n','<leader>ss',builtin.live_grep)
