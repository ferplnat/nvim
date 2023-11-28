local M = {}

require('monokai-pro').setup({})

M.apply = function()
    vim.cmd.colorscheme('monokai-pro')

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#6b5000" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#6b5000" })
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#fc9867", fg = "#fc9867" })
end

return M
