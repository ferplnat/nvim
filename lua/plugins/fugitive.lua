--- @type LazyPluginSpec
return {
    name = 'fugitive',
    [1] = 'tpope/vim-fugitive',    

    config = function()
        require('marco.remaps.fugitive').apply()
    end,
}
