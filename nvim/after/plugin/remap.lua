vim.api.nvim_set_keymap('i', '<Tab>', '<C-V><Tab>', { noremap = true })

--vim.keymap.set("<C-u>","<C-u>zz")
--vim.keymap.set("<C-d>","<C-d>zz") 

--LSP
vim.keymap.set("n","<leader>t",vim.lsp.buf.rename)
vim.keymap.set("n","<leader>K",vim.lsp.buf.hover)
vim.keymap.set("n","<leader>j",vim.lsp.buf.definition)
vim.keymap.set("n","<leader>d","<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>k", "<cmd>bnext<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>bprev<CR>")
