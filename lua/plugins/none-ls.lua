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
            'codespell',
            'hadolint',
            'nilaway',
            'prettierd',
            'revive',
            'selene',
            'shellcheck',
            'shfmt',
            'sqlfluff',
            'staticcheck',
            'yamllint',
        }

        require('mason-tool-installer').setup({
            ensure_installed = ensure_installed,
            run_on_start = true,
            start_delay = 3000,
        })

        local builtins = require('null-ls.builtins')
        require('null-ls').setup({
            update_in_insert = false,
            debounce = 1000,                         -- I enter and exit insert mode a lot. Also helps with macro recording.
            sources = {
                builtins.diagnostics.alex,           -- Markdown linter
                builtins.diagnostics.codespell,      -- Spell checker
                builtins.diagnostics.hadolint,       -- Dockerfile linter
                builtins.diagnostics.revive,         -- Go linter
                builtins.diagnostics.selene,         -- Lua linter
                builtins.diagnostics.staticcheck,    -- Go linter
                builtins.diagnostics.sqlfluff.with({ -- SQL linter
                    extra_args = {
                        "--dialect",
                        "tsql",
                        "--config",
                        vim.fn.stdpath('config') .. "/lsp-config-files/sqlfluff/default.cfg"
                    },
                }),
                builtins.diagnostics.yamllint, -- YAML linter
            },
        })
    end,
}
