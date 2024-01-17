--- @type LazyPluginSpec
return {
    name = 'colorizer',
    [1] = 'norcalli/nvim-colorizer.lua',

    config = function()
        require('colorizer').setup(
            {
                '*',
            },
            {
                names = false,
            }
        )
    end,
}
