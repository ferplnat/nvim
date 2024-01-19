local M = {}

M.apply = function()
    local textobjs = require('various-textobjs')

    vim.keymap.set({ "o", "x" }, 'i_', function() textobjs.lineCharacterwise("inner") end,
        { desc = "Select current line, characterwise" })

    vim.keymap.set({ "o", "x" }, 'a_', function() textobjs.lineCharacterwise("outer") end,
        { desc = "Select current line, characterwise" })
end

return M
