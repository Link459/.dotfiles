require('lualine').setup ({
    options = {
        font_family = 'JetBrains Mono',
        font_size = 12,
        icons_enabled = true,
        theme = 'auto',
        section_separators = {left = '', right = ''},
        component_separators = {left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'filename','filesize'},
        lualine_c = {'diagnostics'},
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {
        lualine_a = {'branch'},
        lualine_b = {},
        lualine_c = {'diff'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'searchcount'}
    },
    inactive_winbar = {},
    extensions = {}
})
