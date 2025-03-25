--- @type LazyPluginSpec
return {
    name = 'truefalse',
    [1] = 'ferplnat/truefalse.nvim',

    config = function()
        require('truefalse').setup()
    end,
}
