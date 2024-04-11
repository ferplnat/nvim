--- @type LazyPluginSpec
return {
    name = 'none-ls',
    [1] = 'nvimtools/none-ls.nvim',

    dependencies = {
        'lsp',
        'nvim-lua/plenary.nvim',
        'williamboman/mason.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    config = function()
        local ensure_installed = {
            'alex',
            'nilaway',
            'revive',
            'selene',
            'staticcheck',
            'shellcheck',
            'sqlfluff',
            'yamllint',
        }

        require('mason-tool-installer').setup({
            ensure_installed = ensure_installed,
            run_on_start = true,
            start_delay = 3000,
        })

        local builtins = require('null-ls.builtins')
        require('null-ls').setup({
            sources = {
                builtins.diagnostics.alex,
                builtins.diagnostics.revive,
                builtins.diagnostics.selene,
                builtins.diagnostics.staticcheck,
                builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "tsql", "--config", vim.fn.stdpath('config') .. "/lspconfigs/sqlfluff/default.cfg" },
                }),
                builtins.diagnostics.yamllint,
            },
        })
    end,
}
