return { 'ThePrimeagen/harpoon' ,
branch = 'harpoon2',
dependencies = { "nvim-lua/plenary.nvim" },
config = function() 
    local harpoon = require("harpoon")
    harpoon:setup()
    local harpoon_extensions = require("harpoon.extensions")
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
end,
keys  = {
    {'<leader>ha',function() require('harpoon'):list():add() end},
    {'<leader>hs',function() 
        local harpoon = require('harpoon')
        harpoon.ui:toggle_quick_menu(harpoon:list()) end},
        {'<leader>h1',function() require('harpoon'):list():select(1) end},
        {'<leader>h2',function() require('harpoon'):list():select(2) end},
        {'<leader>h3',function() require('harpoon'):list():select(3) end},
        {'<leader>h4',function() require('harpoon'):list():select(4) end},
        {'<leader>h5',function() require('harpoon'):list():select(5) end},
        {'<leader>h6',function() require('harpoon'):list():select(6) end},
        {'<leader>h7',function() require('harpoon'):list():select(7) end},
        {'<leader>h8',function() require('harpoon'):list():select(8) end},
    },
}
