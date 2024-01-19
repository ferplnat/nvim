local M = {}

M.apply = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

return M
