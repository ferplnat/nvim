--- @type LazyPluginSpec
return {
    name = 'indent-blankline',
    [1] = 'lukas-reineke/indent-blankline.nvim',
    version = "*",

    config = function()
        require('ibl').setup({
            scope = {
                enabled = true,
            },
        })
    end,
}
