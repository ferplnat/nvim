local luasnip = require('luasnip')

luasnip.setup({
    load_ft_func =
        require("luasnip.extras.filetype_functions").extend_load_ft({
            psm1 = {"powershell"},
    })
})
