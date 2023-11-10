vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    pattern = 'Cargo.toml',
    callback = function()
        local cmp = require('cmp')
        cmp.setup.buffer({ sources = { { name = 'crates' } } })
    end,
})

return {
                'saecki/crates.nvim',
                event = { 'BufRead Cargo.toml' },
                requires = { { 'nvim-lua/plenary.nvim' } },
                config = function()
                    require('crates').setup()
                end,
            }
