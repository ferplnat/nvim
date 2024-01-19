local M = {}

M.apply = function()
    vim.keymap.set("n", "<leader>cp", require('copilot.panel').open, { desc = "Open [c]opilot [p]anel." })
end

M.suggestion_maps = {
                    accept = "<C-d>",
                    next = "<C-.>",
                    prev = "<C-,>",
                    dismiss = "<C-y>",
}

return M
