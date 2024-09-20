vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.wrap = false

vim.o.relativenumber = true
vim.o.nu = true

vim.o.termguicolors = true
vim.o.scrolloff = 8

vim.o.hlsearch = false

vim.o.updatetime = 50

vim.o.guicursor = ''
vim.g.mapleader = ' '

vim.o.backup = false
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true

vim.g.netrw_liststyle = 3

vim.loader.enable()
