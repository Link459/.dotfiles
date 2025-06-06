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
        {'rafamadriz/friendly-snippets'},

        {'simrat39/inlay-hints.nvim'},

        {'onsails/lspkind.nvim'},
    },
    config = function() 
        local ih = require("inlay-hints")
        local lspkind = require('lspkind')
        local lspconfig = require('lspconfig')
        ih.setup({
            only_current_line = true
        })




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
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    local ls
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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

        lspconfig.clangd.setup({
            on_attach = function(c,b) ih.on_attach(c,b) end,
            cmd = { "clangd",--"/run/current-system/sw/bin/clangd",
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

    lspconfig.rust_analyzer.setup({
        cmd = { "rust-analyzer" }, --"/nix/store/7ls6k3101cgvrxg1qvh8k0apb4smfyqx-profile/bin/rust-analyzer" 
        capabilities = capabilities,
    })
	lspconfig.slangd.setup( {
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

    function get_glsl_cmd() 
        local cmd = { "glslls", "--stdin" }

        if vim.g.glsl_target then
            table.insert(cmd, "--target-env=" .. vim.g.glsl_target)
        end

        return cmd
    end

    function glsl_start()
        local cmd = { "glslls", "--stdin" }

        if vim.g.glsl_target then
            table.insert(cmd, "--target-env=" .. vim.g.glsl_target)
        end
        lspconfig.glslls.setup{
            cmd = cmd,
        }
    end

    lspconfig.glsl_analyzer.setup{}
    --glsl_start()

    -- sets the --target-env of glslls so you can choose between vulkan and opengl
    vim.api.nvim_create_user_command('GlslTarget', function(opts)
        vim.g.glsl_target = opts.args
        local clients = vim.lsp.get_active_clients()
        for _, client in ipairs(clients) do
            if client.name == "glslls" then
                client.stop()
            end
        end
        glsl_start()
    end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        return { 'vulkan', 'vulkan1.0', 'vulkan1.1' , 'vulkan1.2' , 'vulkan1.3', 'opengl', 'opengl4.5' }
    end,
})

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
