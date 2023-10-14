local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local M = { "nvimtools/none-ls.nvim", event = "VeryLazy", opts = function()
    local null_ls = require("null-ls")
    return {
        sources = {
            -- cmake
            null_ls.builtins.diagnostics.cmake_lint,
            null_ls.builtins.formatting.cmake_format,

            -- nix
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.formatting.nixfmt,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = bufnr,
                })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    }
end
}
return M
