--- @type LazyPluginSpec
return {
    name = 'none-ls',
    [1] = 'nvimtools/none-ls.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    config = function()
        local builtins = require('null-ls.builtins')

        require('null-ls').setup({
            sources = {
                builtins.diagnostics.alex,
                builtins.diagnostics.jsonlint,
                builtins.diagnostics.selene,
                builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "transact-sql" },
                }),
                builtins.diagnostics.yamllint,
            },
        })
    end,
}
