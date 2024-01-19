--- @type LazyPluginSpec
return {
    name = 'lsp',
    [1] = 'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Fixes for Omnisharp
        'Hoffs/omnisharp-extended-lsp.nvim',
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
            'lua_ls',
            'marksman',
            'taplo',
        }

        if jit.os == 'Windows' then
            table.insert(ensure_installed, 'powershell_es')
            table.insert(ensure_installed, 'omnisharp@v1.39.8') -- 1.39.10 is broken; 1.39.9 is worse.
        end

        -- neodev needs to be called before lspconfig
        require("neodev").setup({})

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local my_onattach = function(client, bufnr)
            remaps.on_attach(bufnr)

            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
            if client.name == "omnisharp" then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end

        local handlers = {
            [1] = function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                })
            end,

            ["powershell_es"] = function()
                -- LSP Server Specific Configs
                require('lspconfig').powershell_es.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                    shell = "powershell.exe", -- Make sure we're using Windows PowerShell 5.1
                    filetypes = {
                        "ps1",
                        "psm1",
                    },
                    settings = {
                        powershell = {
                            codeFormatting = {
                                alignPropertyValuePairs = true,
                                addWhitespaceAroundPipe = true,
                                avoidSemicolonsAsLineTerminators = true,
                                openBraceOnSameLine = true,
                                newLineAfterCloseBrace = true,
                                useCorrectCasing = true,
                                useConstantStrings = true,
                            },
                            scriptAnalysis = {
                                enable = true,
                            },
                        },
                    },
                })
            end,

            ["omnisharp"] = function()
                vim.fn.setenv("OMNISHARPHOME", vim.fn.stdpath('config') .. '/lspconfigs/omnisharp/')

                require('lspconfig').omnisharp.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                    handlers = {
                        ["textDocument/definition"] = require('omnisharp_extended').handler,
                    },

                    -- Disable all so that omnisharp.json is used
                    enable_editorconfig_support = false,
                    enable_ms_build_load_projects_on_demand = false,
                    enable_roslyn_analyzers = false,
                    organize_imports_on_format = false,
                    enable_import_completion = false,
                    sdk_include_prereleases = false,
                    analyze_open_documents_only = false,
                })
            end,

            ["yamlls"] = function()
                require('lspconfig').yamlls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                })
            end,

            ["azure_pipelines_ls"] = function()
                require('lspconfig').azure_pipelines_ls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                    settings = {
                        yaml = {
                            schemas = {
                                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                                    "**Azure**.yaml",
                                    "**Azure**.yml",
                                    "**AzDO**.yml",
                                    "**AzDO**.yaml",
                                },
                            },
                        },
                    },
                })
            end,

            ["bicep"] = function()
                require('lspconfig').bicep.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                })
            end,

            ["gopls"] = function()
                require('lspconfig').gopls.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                            },
                            staticcheck = true,
                        },
                    },
                })
            end,

            ["lua_ls"] = function()
                require('lspconfig').lua_ls.setup {
                    on_attach = my_onattach,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                        },
                    },
                }
            end,
        }

        require('mason-lspconfig').setup({
            ensure_installed = ensure_installed,
            handlers = handlers,
        })
    end,
}
