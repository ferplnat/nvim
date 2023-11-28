local state = {}
local scratch_file = vim.fn.expand('~/Documents/working/notes/')
local min_width = vim.o.colorcolumn + 5

local scratch_width = function()
    return math.floor(vim.o.columns * 0.3)
end

local create_scratch_win = function()
    local current_win = vim.api.nvim_get_current_win()

    vim.cmd(string.format("silent! topleft %dvsp +Explore %s", scratch_width(), scratch_file))
    state.hidden = false
    state.scratch_win = vim.api.nvim_get_current_win()
    vim.o.wrap = true
    vim.o.linebreak = true

    vim.api.nvim_set_current_win(current_win)
end

local show_scratch_win = function(winnr)
    local target_win = winnr or state.scratch_win or -1

    if state.hidden == false then
        return
    end

    if not vim.api.nvim_win_is_valid(target_win) then
        create_scratch_win()
        return
    end
end

local hide_scratch_win = function(winnr)
    local target_win = winnr or state.scratch_win

    if not vim.api.nvim_win_is_valid(target_win) then
        return
    end

    vim.api.nvim_win_hide(target_win)
    state.hidden = true
end

local size_scratch_win = function()
    local target_win = state.scratch_win or -1
    if state.hidden == true and scratch_width() > min_width then
        show_scratch_win(target_win)
        return
    end

    if state.hidden == false and scratch_width() < min_width then
        hide_scratch_win(target_win)
        return
    end

    if vim.api.nvim_win_is_valid(target_win) then
        vim.api.nvim_win_set_width(target_win, scratch_width())
    end
end

local auto_command_group = vim.api.nvim_create_augroup("marco-scratchpad", {})

vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, {
    callback = create_scratch_win,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinClosed", "WinNew", "WinResized" }, {
    group = auto_command_group,
    callback = size_scratch_win,
})

return state
