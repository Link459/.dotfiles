function InsertHeaderGuard(filename,guard_name)
    -- Extract the header guard name from the filename
    local guardname = guard_name:upper():gsub("%W", "_")

    -- Check if the header guard has already been inserted
    local already_exists = false
    for line in io.lines(filename) do
        if line:find("#ifndef " .. guardname) then
            already_exists = true
            break
        end
    end

    -- If the header guard doesn't already exist, insert it
    if not already_exists then
        local header_guard = string.format("#ifndef %s\n#define %s\n\n", guardname, guardname)
        local file = io.open(filename, "r+")
        local content = file:read("*all")
        file:seek("set", 0)
        file:write(header_guard .. content .. "\n#endif /* " .. guardname .. " */\n")
        file:close()

    end
end

function OnHeaderSave(args)
    -- Get the full path of the file being saved
    local fname = vim.fn.expand("<afile>")
    local guard_name = vim.fn.expand("%:t")
    -- Insert the header guard
    InsertHeaderGuard(fname,guard_name)
end

-- Add an autocmd to execute the function when a .h or .hpp file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.h" ,"*.hpp" },
    callback = OnHeaderSave,
})
