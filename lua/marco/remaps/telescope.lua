local M = {}

M.apply = function(builtin)
    local function find_fallback()
        if pcall(builtin.git_files) then
            return
        elseif pcall(builtin.find_files) then
            return
        end
    end

    vim.keymap.set('n', '<C-p>', find_fallback, { desc = "Find Git files or files" })
    vim.keymap.set('n', '<leader>t', builtin.builtin, { desc = "Telescope telescope" })
    vim.keymap.set('n', '<leader>pt', builtin.treesitter, { desc = "Telescope treesitter" })
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Telescope buffers" })
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set('n', '<leader>pgs', builtin.git_status, { desc = "Telescope git status" })
    vim.keymap.set('n', '<leader>pgb', builtin.git_branches, { desc = "Telescope git branches" })
    vim.keymap.set('n', '<leader>pgc', builtin.git_commits, { desc = "Telescope git commits" })
    vim.keymap.set('n', '<leader>pgh', builtin.git_stash, { desc = "Telescope git stash" })

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
