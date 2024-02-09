local M = {}

M.apply = function(builtin)
    local function find_fallback()
        if pcall(builtin.git_files) then
            return
        elseif pcall(builtin.find_files) then
            return
        end
    end

    vim.keymap.set('n', '<Leader>pgf', find_fallback, { desc = "Find Git files or files [telescope]" })
    vim.keymap.set('n', '<Leader>pt', builtin.builtin, { desc = "Telescope telescope [telescope]" })
    vim.keymap.set('n', '<Leader>pts', builtin.treesitter, { desc = "Telescope treesitter [telescope]" })
    vim.keymap.set('n', '<Leader>ph', builtin.help_tags, { desc = "Telescope treesitter [telescope]" })
    vim.keymap.set('n', '<Leader>pf', builtin.find_files, { desc = "Telescope find files [telescope]" })
    vim.keymap.set('n', '<Leader>pb', builtin.buffers, { desc = "Telescope buffers [telescope]" })
    vim.keymap.set('n', '<Leader>ps', builtin.live_grep, { desc = "Telescope live grep [telescope]" })
    vim.keymap.set('n', '<Leader>pgs', builtin.git_status, { desc = "Telescope git status [telescope]" })
    vim.keymap.set('n', '<Leader>pgb', builtin.git_branches, { desc = "Telescope git branches [telescope]" })
    vim.keymap.set('n', '<Leader>pgc', builtin.git_commits, { desc = "Telescope git commits [telescope]" })
    vim.keymap.set('n', '<Leader>pgh', builtin.git_stash, { desc = "Telescope git stash [telescope]" })

    vim.api.nvim_create_user_command('TGBranches', builtin.git_branches, {})
    vim.api.nvim_create_user_command('TGCommits', builtin.git_commits, {})
    vim.api.nvim_create_user_command('TGStatus', builtin.git_status, {})
    vim.api.nvim_create_user_command('TGStash', builtin.git_stash, {})
end

M.cmdline = {
    complete      = '<Tab>',
    run_selection = '<C-CR>',
    run_input     = '<CR>',
}

return M
