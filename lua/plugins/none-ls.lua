--- @type LazyPluginSpec
return {
    name = 'none-ls',
    [1] = 'nvimtools/none-ls.nvim',

    dependencies = {
        'nvim-lua/plenary.nvim',
        'williamboman/mason.nvim',
    },

    config = function()
        local builtins = require('null-ls.builtins')
        local ensure_installed = {
            'alex',
            'nilaway',
            'revive',
            'selene',
            'staticcheck',
            'sqlfluff',
            'yamllint',
        }

        local mason_registry = require('mason-registry')
        mason_registry.update()

        for _, linter in ipairs(ensure_installed) do
            if not mason_registry.is_installed(linter) then
                vim.api.nvim_echo({ { 'Installing ' .. linter, 'Type' } }, true, {})
                mason_registry.get_package(linter):install()
            end
        end

        require('null-ls').setup({
            sources = {
                builtins.diagnostics.alex,
                builtins.diagnostics.revive,
                builtins.diagnostics.selene,
                builtins.diagnostics.staticcheck,
                builtins.diagnostics.sqlfluff.with({
                    extra_args = { "--dialect", "transact-sql" },
                }),
                builtins.diagnostics.yamllint,
            },
        })
    end,
}
