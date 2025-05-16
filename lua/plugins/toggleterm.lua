--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'toggleterm',
    [1] = 'akinsho/toggleterm.nvim',
    version = "*",

    config = function()
        local remaps = require('marco.remaps.toggleterm')

        require('toggleterm').setup({
            open_mapping = remaps.open_mapping,
            insert_mappings = false,
            hide_numbers = false,
            direction = 'horizontal',
            size = 30,
            persist_size = true,
            shade_terminals = false,

            highlights = {
                Normal = {
                    link = 'ToggleTermNormal',
                },

                NormalFloat = {
                    link = 'ToggleTermNormalFloat',
                },

                StatusLine = {
                    link = 'ToggleTermStatusLine',
                },
            },

            on_open = function(term)
                vim.cmd('startinsert!')
                remaps.on_open(term)
            end,
        })

        remaps.apply()
    end,
}
