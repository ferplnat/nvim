local util = require('formatter.util')
require('formatter').setup({
    logging = true,
    filetype = {
        ["*"] = {
            -- require("formatter.filetypes.any").remove_trailing_whitespace,
            -- require('formatter.defaults.prettier'),
            -- TODO: Get prettier working
        }
    }
})
