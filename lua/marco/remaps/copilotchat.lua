local M = {}

M.apply = function()
    vim.keymap.set({ "n" }, "<leader>ccb", ":CopilotChatBuffer ",
        { noremap = true, silent = true, desc = "CopilotChat - Chat with current buffer" })

    vim.keymap.set({ "n" }, "<leader>cce", "<cmd>CopilotChatExplain<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Explain code" })

    vim.keymap.set({ "n" }, "<leader>cct", "<cmd>CopilotChatTests<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Generate tests" })

    vim.keymap.set({ "n" }, "<leader>ccT", "<cmd>CopilotChatVsplitToggle<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Toggle Vsplit" })

    vim.keymap.set({ "x" }, "<leader>ccv", ":CopilotChatVisual ",
        { noremap = true, silent = true, desc = "CopilotChat - Open in vertical split" })

    vim.keymap.set({ "x" }, "<leader>ccx", ":CopilotChatInPlace<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Run in-place code" })

    vim.keymap.set({ "n" }, "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Fix diagnostic" })

    vim.keymap.set({ "n" }, "<leader>ccr", "<cmd>CopilotChatReset<cr>",
        { noremap = true, silent = true, desc = "CopilotChat - Reset chat history and clear buffer" })
end

return M
