require 'plugins.headerguard'

return {
require 'plugins.alpha',
require 'plugins.crates',
require 'plugins.hardtime',
require 'plugins.harpoon',
require 'plugins.lsp',
require 'plugins.lualine',
require 'plugins.null-ls',
require 'plugins.telescope',
require 'plugins.todocomments',
require 'plugins.tokyonight',
require 'plugins.treesitter',
require 'plugins.trouble',
require 'plugins.troublesum',
defaults = {
        lazy = true
    },
    { 'windwp/nvim-autopairs' , config = function() require('nvim-autopairs').setup{} end },
}

