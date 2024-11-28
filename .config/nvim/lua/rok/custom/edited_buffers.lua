local edited_buffers = {}

-- Function to check if the buffer is listed
local function is_valid_buffer(bufnr)
    return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
end

-- Function to update the buffer order when a buffer is opened
local function add_buffer_to_queue()
    local bufnr = vim.api.nvim_get_current_buf()
    if not is_valid_buffer(bufnr) then
        return
    end

    -- Only add the buffer if it's not already the last item in the queue
    if edited_buffers[#edited_buffers] ~= bufnr then
        for i, buf in ipairs(edited_buffers) do
            if buf == bufnr then
                table.remove(edited_buffers, i)
                break
            end
        end
        table.insert(edited_buffers, bufnr)
    end
end

-- Function to remove the buffer from the list when closed
local function remove_buffer_from_queue()
    local bufnr = vim.api.nvim_get_current_buf()
    for i, buf in ipairs(edited_buffers) do
        if buf == bufnr then
            table.remove(edited_buffers, i)
            break
        end
    end
end

-- Add the current buffer to the list when it's opened or edited
vim.api.nvim_create_autocmd({ "BufReadPost", "TextChanged", "TextChangedI" }, {
    callback = add_buffer_to_queue,
})

-- Remove the buffer from the list when it's closed
vim.api.nvim_create_autocmd("BufDelete", {
    callback = remove_buffer_from_queue,
})

-- Function to go to the next buffer in the edited order without cycling endlessly
local function goto_next_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    for i, buf in ipairs(edited_buffers) do
        if buf == bufnr then
            local next_index = i + 1
            if next_index <= #edited_buffers then
                vim.api.nvim_set_current_buf(edited_buffers[next_index])
            else
                print("Reached the end of the buffer list")
            end
            break
        end
    end
end

-- Function to go to the previous buffer in the edited order without cycling endlessly
local function goto_prev_buffer()
    local bufnr = vim.api.nvim_get_current_buf()
    for i, buf in ipairs(edited_buffers) do
        if buf == bufnr then
            local prev_index = i - 1
            if prev_index >= 1 then
                vim.api.nvim_set_current_buf(edited_buffers[prev_index])
            else
                print("Reached the beginning of the buffer list")
            end
            break
        end
    end
end
-- Optionally, map the functions to keys
vim.keymap.set("n", "<A-i>", goto_next_buffer, { noremap = true, silent = true })
vim.keymap.set("n", "<A-o>", goto_prev_buffer, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", function()
    print(vim.inspect(edited_buffers))
end, { desc = "Print edited buffers" })
