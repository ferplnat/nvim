local state = {}
local scratch_file = vim.fn.expand('~/Documents/working/notes/vimscratch.norg')
local min_width = 40

local scratch_width = function()
    return math.floor(vim.o.columns * 0.3)
end

local create_scratch_win = function()
    local current_win = vim.api.nvim_get_current_win()

    print(string.format("%dvsp %s", scratch_width(), vim.fn.expand('~/vimscratch.txt')))

    vim.cmd(string.format("silent! topleft %dvsp %s", scratch_width(), scratch_file))
    vim.o.wrap = true

    state.scratch_win = vim.api.nvim_get_current_win()

    vim.api.nvim_set_current_win(current_win)
    state.hidden = false
end

local auto_command_group = vim.api.nvim_create_augroup("marco-scratchpad", {})

vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, {
    callback = create_scratch_win,
})

vim.api.nvim_create_autocmd({ "VimResized", "WinClosed", "WinNew", "WinResized" }, {
    group = auto_command_group,
    callback = function()
        if not vim.api.nvim_win_is_valid(state.scratch_win) then
            if state.hidden == true and scratch_width() > min_width then
                create_scratch_win()
                return
            end

            return
        end

        if scratch_width() < min_width then
            vim.api.nvim_win_hide(state.scratch_win)
            state.hidden = true
            return
        end

        vim.api.nvim_win_set_width(state.scratch_win, scratch_width())
    end,
})

return state
