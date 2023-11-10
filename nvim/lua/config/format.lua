function format(args)
	vim.lsp.buf.format(nil)
end

vim.api.nvim_create_autocmd({ 'BufWritePost'}, {
  pattern = { '*.rs','*.h','*.cpp' },
  callback = format,
})
