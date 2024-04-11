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
        'jmederosalvarado/roslyn.nvim',
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

        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())

        local my_onattach = function(_, bufnr)
            remaps.on_attach(bufnr)
            if vim.bo[bufnr].filetype == 'ps1' then
                vim.cmd.syntax({ args = { 'enable' }, mods = { silent = true } })
            end

            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end

        if vim.fn.isdirectory(vim.fn.expand('~/nvim-lsp/fastbuild-vscode')) == 1 then
            vim.filetype.add({
                extension = {
                    ['bff'] = 'fastbuild',
                }
            })

            require('lspconfig.configs').fastbuild_vscode = {
                default_config = {
                    cmd = { 'node', vim.fn.expand('~/nvim-lsp/fastbuild-vscode/server/out/server.js'), '--stdio' },
                    filetypes = { 'fastbuild' },
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern('fbuild.bff')(fname) or vim.fn.getcwd()
                    end,
                    settings = {
                        fastbuild = {
                            logPerformanceMetrics = false,
                            inputDebounceDelay = 500,
                        },
                    },
                },
            }

            require('lspconfig').fastbuild_vscode.setup({
                on_attach = my_onattach,
            })
        end

        -- LSP Server Specific Configs
        local handlers = {
            [1] = function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                })
            end,

            ["powershell_es"] = function()
                local on_new_config = function(new_config, _)
                    if jit.os == 'Windows' and vim.fn.executable('pwsh') == 1 then
                        vim.ui.select({ 'powershell.exe', 'pwsh' }, {
                                prompt = "Select a shell for PowerShell Editor Services",
                            },
                            function(selected)
                                new_config.shell = selected
                            end
                        )
                    end
                    require('lspconfig.server_configurations.powershell_es').default_config.on_new_config(new_config, _)
                end

                require('lspconfig').powershell_es.setup({
                    capabilities = lsp_capabilities,
                    on_attach = my_onattach,
                    on_new_config = on_new_config,
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
                require("roslyn").setup({
                    dotnet_cmd = "dotnet",                -- this is the default
                    roslyn_version = "4.11.0-1.24179.11", -- this is the default
                    on_attach = my_onattach,
                    capabilities = lsp_capabilities,
                })


                vim.fn.setenv("OMNISHARPHOME", vim.fn.stdpath('config') .. '/lspconfigs/omnisharp/')

                --local omnisharp_cmd
                --if jit.os == 'Windows' then
                --    omnisharp_cmd = { vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/omnisharp.exe' }
                --end

                --require('lspconfig').omnisharp.setup({
                --    cmd = omnisharp_cmd,
                --    capabilities = lsp_capabilities,
                --    on_attach = my_onattach,
                --    handlers = {
                --        ["textDocument/definition"] = require('omnisharp_extended').handler,
                --    },
                --    root_dir = require('lspconfig').util.root_pattern('*.sln', '*.csproj', 'omnisharp.json',
                --        'function.json'),

                --    -- Disable all so that omnisharp.json is used
                --    enable_editorconfig_support = false,
                --    enable_ms_build_load_projects_on_demand = false,
                --    enable_roslyn_analyzers = false,
                --    organize_imports_on_format = false,
                --    enable_import_completion = false,
                --    sdk_include_prereleases = false,
                --    analyze_open_documents_only = false,
                --})
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
