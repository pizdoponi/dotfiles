-- set visually selected text to the repl based on following priority:
-- 1. dap, if dap is running
-- 2. iron, if iron is active
-- 3. toggleterm

local function get_visual_selection()
    -- HACK: Break out of visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", false, true, true), "nx", false)
    local b_line, b_col
    local e_line, e_col

    local mode = vim.fn.visualmode()

    b_line, b_col = unpack(vim.fn.getpos("'<"), 2, 3)
    e_line, e_col = unpack(vim.fn.getpos("'>"), 2, 3)

    if e_line < b_line or (e_line == b_line and e_col < b_col) then
        e_line, b_line = b_line, e_line
        e_col, b_col = b_col, e_col
    end

    local lines = vim.api.nvim_buf_get_lines(0, b_line - 1, e_line, 0)

    if #lines == 0 then
        return
    end

    if mode == "\22" then
        local b_offset = math.max(1, b_col) - 1
        for ix, line in ipairs(lines) do
            -- On a block, remove all preciding chars unless b_col is 0/negative
            lines[ix] = vim.fn.strcharpart(line, b_offset, math.min(e_col, vim.fn.strwidth(line)))
        end
    elseif mode == "v" then
        local last = #lines
        local line_size = vim.fn.strwidth(lines[last])
        local max_width = math.min(e_col, line_size)
        if max_width < line_size then
            -- If the selected width is smaller then total line, trim the excess
            lines[last] = vim.fn.strcharpart(lines[last], 0, max_width)
        end

        if b_col > 1 then
            -- on a normal visual selection, if the start column is not 1, trim the beginning part
            lines[1] = vim.fn.strcharpart(lines[1], b_col - 1)
        end
    end

    -- remove empty lines
    local b_lines = {}
    for _, line in ipairs(lines) do
        if line:gsub("^%s*(.-)%s*$", "%1") ~= "" then
            table.insert(b_lines, line)
        end
    end
    return b_lines
end

local function send_to_repl()
    local lines_to_send = get_visual_selection()
    local text_to_send = table.concat(lines_to_send, "\n")

    local dap_ok, dap = pcall(require, "dap")
    if dap_ok and dap.session() ~= nil then
        -- join the text_to_send into a single string by joining with newlines
        dap.repl.execute(text_to_send)
        return
    end

    local iron_ok, iron = pcall(require, "iron")
    if iron_ok then
        local ft = vim.bo.filetype
        iron.core.send(ft, lines_to_send)
        return
    end

    local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
    if toggleterm_ok then
        toggleterm.exec(text_to_send)
        return
    end
end

vim.keymap.set("v", "<cr>", send_to_repl, { noremap = true, silent = false, desc = "Send to repl" })
