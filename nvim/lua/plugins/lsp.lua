return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},

        -- Autocompletion
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},

        {'onsails/lspkind.nvim'},
    },
    config = function() 
        local lspkind = require('lspkind')

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}
        local cmp_mappings = {
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<Tab>'] = cmp.mapping.confirm({ select = true,behavior = cmp.ConfirmBehavior.Insert,}),
            ["<C-Space>"] = cmp.mapping.complete(),
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    local ls
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp_mappings,
            window = {
                completion = cmp.config.window.bordered({col_offset = 3, winhighlight = 'Normal:CmpNormal'}),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = {'menu', 'abbr', 'kind'},

                -- here is where the change happens
                format = lspkind.cmp_format({
                    mode = 'symbol', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    symbol_map = {
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = "",
                    },

                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]",
                    },
                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function (entry, vim_item)
                        return vim_item
                    end
                })
            },

            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,

                    function(entry1, entry2)
                        local _, entry1_under = entry1.completion_item.label:find "^_+"
                        local _, entry2_under = entry2.completion_item.label:find "^_+"
                        entry1_under = entry1_under or 0
                        entry2_under = entry2_under or 0
                        if entry1_under > entry2_under then
                            return false
                        elseif entry1_under < entry2_under then
                            return true
                        end
                    end,

                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
            enabled = function()
                -- disable completion in comments
                local context = require 'cmp.config.context'
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == 'c' then
                    return true
                else
                    return not context.in_treesitter_capture("comment") 
                    and not context.in_syntax_group("Comment")
                end
            end,
            sources = cmp.config.sources({
                {name= 'nvim_lsp'},
                {name= 'luasnip'},
            }),
            view = {
                entries = {
                    follow_cursor = true
                }
            },
        })

        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        --local lspconfig = require('lspconfig')

        --lspconfig.clangd.setup({

            vim.lsp.config('clangd',{
                cmd = { "clangd",
                "--enable-config",
                "--background-index",
                "--background-index-priority=normal",
                "--header-insertion=never",
                "--function-arg-placeholders=false",
                "--completion-style=bundled",
                "--all-scopes-completion",
                "--clang-tidy"
            },
            capabilities = capabilities,
        })
        vim.lsp.enable('clangd');

        vim.lsp.config('rust_analyzer',{
            cmd = { "rust-analyzer" },
            capabilities = capabilities,
        })
        vim.lsp.enable('rust-analyzer')

        vim.lsp.config('slangd',{
            cmd = {"slangd"},
            settings = {
                slang = {
                    predefinedMacros = {},
                    inlayHints = {
                        deducedTypes = true,
                        parameterNames = true,
                    }
                }
            }
        })
        vim.lsp.enable('slangd')

        --lspconfig.glsl_analyzer.setup{}
        vim.lsp.enable('glsl_analyzer')

        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "<leader>j", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>k", function() vim.lsp.buf.hover() end, opts)
        --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


        vim.diagnostic.config({
            virtual_text = true
        })end,
    }
