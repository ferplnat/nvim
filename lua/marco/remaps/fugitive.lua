local M = {}

M.apply = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open ':Git' command line" })
end

return M
