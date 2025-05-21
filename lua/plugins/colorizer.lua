--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'colorizer',
    [1] = 'catgoose/nvim-colorizer.lua',

    config = function()
        require('colorizer').setup(
            {
                '*',
                '!vim',
                '!lazy',
                '!oil',
                '!noice',
            },
            {
                names = false,
            }
        )
    end,
}
