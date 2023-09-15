local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--local null_ls = require("null-ls")

local M = { "jose-elias-alvarez/null-ls.nvim", event = "VeryLazy", opts = {
  --sources = {
    -- c++
   -- null_ls.builtins.formatting.clang_format,

    --null_ls.builtins.diagnostics.cmake_lint,

    -- nix
    --null_ls.builtins.code_actions.statix,
    --null_ls.builtins.formatting.nixfmt,
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
return M
