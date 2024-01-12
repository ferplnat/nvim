return {
    'lukas-reineke/indent-blankline.nvim',
    version = "*",

    config = function()
        require('ibl').setup({
            scope = {
                enabled = true,
            },
        })
    end,
}
