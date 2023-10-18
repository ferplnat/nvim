local builtin = require('telescope.builtin')

local function find_fallback()
    if pcall(builtin.git_files) then
        return
    elseif pcall(builtin.find_files) then
        return
    end
end

require('plenary.filetype').add_file('ps1')

vim.keymap.set('n', '<C-p>', find_fallback, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.api.nvim_create_user_command('TGBranches', builtin.git_branches, {})
vim.api.nvim_create_user_command('TGCommits', builtin.git_commits, {})
vim.api.nvim_create_user_command('TGStatus', builtin.git_status, {})
vim.api.nvim_create_user_command('TGStash', builtin.git_stash, {})
