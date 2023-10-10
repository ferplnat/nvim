require('no-neck-pain').setup({
    autocmds = {
        enableOnVimEnter = true,
        enableOnTabEnter = true,
        reloadOnColorSchemeChange = true,
    },

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
