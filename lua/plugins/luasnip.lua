--- @type LazyPluginSpec
return {
    name = 'luasnip',
    [1] = 'L3MON4D3/LuaSnip',
    version = "*",

    dependencies = {
        'rafamadriz/friendly-snippets', -- Snippet library
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
