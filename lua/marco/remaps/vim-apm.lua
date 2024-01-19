local M = {}

M.apply = function(apm)
    vim.keymap.set("n", "<leader>apm", function()
        apm:toggle_monitor()
    end)
end

return M
