--- @module 'lazy.types'
--- @type LazyPluginSpec[]
return {
    {
        name = 'vim-fugitive',
        [1] = 'tpope/vim-fugitive',

        config = function()
            require('marco.remaps.fugitive').apply()
        end,
    },
    {
        name = 'repeat',
        [1] = 'tpope/vim-repeat',
    },
    {
        name = 'vim-sleuth',
        [1] = 'tpope/vim-sleuth',
    },
}
