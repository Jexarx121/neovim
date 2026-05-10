local terminals = {}
local current = 1
local hidden = false

local function open_terminal()
    vim.cmd("botright vsplit | terminal")
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    table.insert(terminals, { buf = buf, win = win })
    current = #terminals

    vim.cmd("startinsert")
end

local function get_current()
    return terminals[current]
end

local function switch_terminal(dir)
    if #terminals == 0 then return end

    current = current + dir

    if current < 1 then current = #terminals end
    if current > #terminals then current = 1 end

    local t = terminals[current]

    -- open window if hidden
    if not vim.api.nvim_win_is_valid(t.win) then
        vim.cmd("botright vsplit")
        vim.api.nvim_set_current_buf(t.buf)
        t.win = vim.api.nvim_get_current_win()
    else
        vim.api.nvim_set_current_win(t.win)
    end

    vim.cmd("startinsert")
end

local function delete_terminal()
    if #terminals == 0 then return end

    local t = table.remove(terminals, current)

    if t and vim.api.nvim_buf_is_valid(t.buf) then
        vim.api.nvim_buf_delete(t.buf, { force = true })
    end

    if current > #terminals then
        current = #terminals
    end

    if #terminals > 0 then
        switch_terminal(0)
    end
end

local function toggle_all_terminals()
    if hidden then
        -- show all
        for _, t in ipairs(terminals) do
            if not vim.api.nvim_win_is_valid(t.win) then
                vim.cmd("botright vsplit")
                vim.api.nvim_set_current_buf(t.buf)
                t.win = vim.api.nvim_get_current_win()
            end
        end
        hidden = false
    else
        -- hide all (close windows only)
        for _, t in ipairs(terminals) do
            if vim.api.nvim_win_is_valid(t.win) then
                vim.api.nvim_win_hide(t.win)
            end
        end
        hidden = true
    end
end

-- leader t → new terminal
vim.keymap.set("n", "<leader>t", open_terminal, { desc = "New terminal" })

-- leader td → delete current terminal
vim.keymap.set("n", "<leader>td", delete_terminal, { desc = "Delete terminal" })

-- leader ts → toggle show/hide all terminals
vim.keymap.set("n", "<leader>st", toggle_all_terminals, { desc = "Toggle terminals visibility" })

-- Ctrl-j / Ctrl-k → switch terminals
vim.keymap.set("n", "<C-l>", function() switch_terminal(1) end, { desc = "Next terminal" })
vim.keymap.set("n", "<C-h>", function() switch_terminal(-1) end, { desc = "Prev terminal" })

-- Esc → exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
