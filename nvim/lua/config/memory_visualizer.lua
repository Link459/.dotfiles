function get_visualization() 
    local curr = vim.fn.expand("<cword>")
    local path = vim.fn.expand("%:p")
    local cmd = 'memory-layout-visualizer ' .. path .. '  ' .. curr
    local output = vim.fn.system(cmd)

    local buf = vim.api.nvim_create_buf(false, true)
    local lines = vim.split(output, "\n")
    local width = vim.api.nvim_get_option("columns") 
    local height = vim.api.nvim_get_option("lines")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local opts = {
        relative = 'editor',               
        width = math.floor(width * 0.8),    
        height = math.floor(height * 0.3), 
        col = math.floor(width * 0.1),    
        row = math.floor(height * 0.1),  
        style = 'minimal',
        border = 'rounded',
    }

    local win = vim.api.nvim_open_win(buf, true, opts)
    function close_window_on_leave()
        if vim.api.nvim_get_current_win() == win then
            return
        end

        if win == nil then
            return
        end
        vim.api.nvim_win_close(win, true)
        win = nil
    end

    vim.api.nvim_create_autocmd('WinLeave', {
        pattern = { '*' },
        callback = close_window_on_leave,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
        pattern = { '*' },
        callback = close_window_on_leave,
    })
end

vim.api.nvim_create_user_command('MemoryVisualizer', get_visualization, {})
