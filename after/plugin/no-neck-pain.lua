local noNeckPain = require('no-neck-pain')
local winSize = function()
    return vim.o.columns / 2
end

noNeckPain.setup({
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        reloadOnColorSchemeChange = true,
    },

    width = winSize(),

    buffers = {
        wo = {
            fillchars = "eob: ",
        },

        bo = {
            filetype = "txt",
        },

        right = {
            enabled = false,
        },

        scratchPad = {
            enabled = true,
            location = '~\\Documents',
            fileName = 'no-neck-pain-scratch',
        }
    },
})

vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        noNeckPain.resize(winSize())
    end,
})
