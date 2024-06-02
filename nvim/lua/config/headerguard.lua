vim.g.header_guard = true

function InsertHeaderGuard(filename,guard_name)
    -- Extract the header guard name from the filename
    local guardname = guard_name:upper():gsub('%W', '_')

    -- Check if the header guard has already been inserted
    local already_exists = false
    for line in io.lines(filename) do
        if line:find('#ifndef ' .. guardname) then
            already_exists = true
            break
        end
    end

    -- If the header guard doesn't already exist, insert it
    if not already_exists then
        local header_guard = string.format('#ifndef %s\n#define %s\n\n', guardname, guardname)
        local file = io.open(filename, 'r+')
        local content = file:read('*all')
        file:seek('set', 0)
        file:write(header_guard .. content .. '\n#endif /* ' .. guardname .. ' */\n')
        file:close()

        vim.cmd('e');
    end
end

function OnHeaderSave(args)
    if vim.g.header_guard then
    local fname = vim.fn.expand('<afile>')
    local guard_name = vim.fn.expand('%:t')
    InsertHeaderGuard(fname,guard_name)
	end
end

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { '*.h' ,'*.hpp' },
    callback = OnHeaderSave,
})

vim.api.nvim_create_user_command('HeaderGuardToggle', function()
        vim.g.header_guard = not vim.g.header_guard
        print('header guard enabled: ' .. tostring(vim.g.header_guard))
    end,{})
