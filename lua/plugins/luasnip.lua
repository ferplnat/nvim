return {
    "L3MON4D3/LuaSnip",
    version = "*",

    dependencies = {
        'rafamadriz/friendly-snippets', -- Snippet library
        'saadparwaiz1/cmp_luasnip',
    },

    config = function()
        local luasnip = require('luasnip')

        luasnip.setup({
            load_ft_func =
                require("luasnip.extras.filetype_functions").extend_load_ft({
                    psm1 = { "powershell" },
                })
        })
    end,
}
