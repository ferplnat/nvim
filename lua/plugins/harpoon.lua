--- @type LazyPluginSpec
return {
    name = 'harpoon',
    [1] = 'ThePrimeagen/harpoon',
    branch = 'harpoon2',

    dependencies = {
        {
            'nvim-lua/plenary.nvim',
            'telescope',
        },
    },
    config = function()
        local harpoon = require('harpoon')
        local remaps = require('marco.remaps.harpoon')
        harpoon:setup({})

        remaps.apply(harpoon)
    end,
}
