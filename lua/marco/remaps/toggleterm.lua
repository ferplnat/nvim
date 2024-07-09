local M = {}

M.apply = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", dir = "git_dir", hidden = true })

    local lazygit_toggle = function()
        lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>g", lazygit_toggle, { noremap = true, desc = "Toggle lazygit" })
end

M.on_open = function(term)
    vim.keymap.set("t", "<C-n>", vim.cmd.stopinsert, { noremap = true, silent = true, buffer = term.bufnr })
end

-- Open toggleterm
M.open_mapping = '<C-\\>'

return M
