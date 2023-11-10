return {
    'ivanjermakov/troublesum.nvim',
    config = function()
        require('troublesum').setup({
            severity_format = {
                '󰅚 ', -- x000f015a
                '󰀪 ', -- x000f002a
                '󰋽 ', -- x000f02fd
                '󰌶 ',}
            })
        end
    }
