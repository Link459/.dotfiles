return {
   'tamton-aquib/duck.nvim',
    config = function()
        vim.api.nvim_create_user_command('Duck' ,function(cmd)
                local duck = require("duck")
                
                if (cmd.args == nil or cmd.args == "") then 
                    duck.hatch()
            	else 
					duck.hatch(cmd.args)
                end
            end,{})
        vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
        vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    end
}
