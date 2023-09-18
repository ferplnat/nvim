local builtin = require('telescope.builtin')

local function find_fallback()
    if pcall(builtin.git_files) then
        return
    elseif pcall(builtin.find_files) then
        return
    end
end

vim.keymap.set('n', '<C-p>', find_fallback, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
