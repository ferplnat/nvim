--- @type LazyPluginSpec
return {
    name = 'lsp',
    [1] = 'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Fixes for Omnisharp
        'Hoffs/omnisharp-extended-lsp.nvim',
        -- Dont use Omnisharp's built-in LSP
        'seblj/roslyn.nvim',
        'folke/neodev.nvim',
    },

    config = function()
        require('mason').setup()
        local remaps = require('marco.remaps.lsp')

        local ensure_installed = {
            'azure_pipelines_ls',
            'bashls',
            'clangd',
            'dockerls',
            'gopls',
            'html',
            'lua_ls',
            'marksman',
            'taplo',
            'terraformls',
            'tflint',
        }

        if jit.os == 'Windows' then
            table.insert(ensure_installed, 'powershell_es')
            table.insert(ensure_installed, 'omnisharp@v1.39.8') -- 1.39.10 is broken; 1.39.9 is worse.
        end

        -- neodev needs to be called before lspconfig
        require("neodev").setup({})

        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())

        local my_onattach = function(_, bufnr)
            remaps.on_attach(bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end

        require("roslyn").setup({
            ---@diagnostic disable-next-line: missing-fields
            config = {
                on_attach = my_onattach,
                settings = {
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                    },
                },
            },
        })

        -- LSP Server Specific Configs
        local handlers = {
            [1] = function(server_name)
                -- Check if there is a handler for this server in my [nvim]/lspconfigs/handlers folder
                local success, handler = pcall(require, 'lspconfigs.handlers.' .. server_name)

                if success and type(handler) == 'function' then
                    handler(lsp_capabilities, my_onattach)
                else
                    if success then
                        vim.api.nvim_notify('Handler is not a function: ' .. server_name,
                            vim.log.levels.ERROR { title = 'LSP Config' })
                    end

                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                        on_attach = my_onattach,
                    })
                end
            end,
        }

        require('lspconfigs.handlers.custom.fastbuild_vscode')(lsp_capabilities, my_onattach)

        require('mason-lspconfig').setup({
            ensure_installed = ensure_installed,
            handlers = handlers,
        })
    end,
}
