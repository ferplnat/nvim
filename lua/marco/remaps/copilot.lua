local M = {}

M.apply = function()
    vim.keymap.set("n", "<leader>cp", require('copilot.panel').open, { desc = "Open [c]opilot [p]anel." })
end

M.suggestion_maps = {
    prev = "<C-a>",
    next = "<C-s>",
    accept = "<C-d>",
    dismiss = "<C-y>",
}

return M
