local M = {}

M.apply = function()
    local textobjs = require('various-textobjs')

    vim.keymap.set({ "o", "x" }, 'i_', function() textobjs.lineCharacterwise("inner") end,
        { desc = "Select current line, characterwise" })

    vim.keymap.set({ "o", "x" }, 'a_', function() textobjs.lineCharacterwise("outer") end,
        { desc = "Select current line, characterwise" })

    vim.keymap.set({ "o", "x" }, 'iS', function() textobjs.subword("inner") end,
        { desc = "Select subword, inner" })

    vim.keymap.set({ "o", "x" }, 'aS', function() textobjs.subword("outer") end,
        { desc = "Select subword, outer" })
end

return M
