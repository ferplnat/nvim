--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'render-markdown',
    [1] = 'MeanderingProgrammer/render-markdown.nvim',

    dependencies = {
        'treesitter',
        'mini',
    },

    config = function()
        require('render-markdown').setup({})
    end,
}
