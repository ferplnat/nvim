require('mason').setup()

local ensure_installed = {
    'azure_pipelines_ls',
    'bashls',
    'clangd',
    'gopls',
    'lua_ls',
}

if jit.os == 'Windows' then
    table.insert(ensure_installed, 'powershell_es')
    table.insert(ensure_installed, 'omnisharp@v1.39.8')
end

-- neodev needs to be called before lspconfig
require("neodev").setup({})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local my_onattach = function(client)
    -- client
end

local handlers = {
    function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = lsp_capabilities,
            on_attach = my_onattach,
        })
    end,

    ["powershell_es"] = function()
        -- LSP Server Specific Configs
        require('lspconfig').powershell_es.setup({
            capabilities = lsp_capabilities,
            shell = "powershell.exe", -- Make sure we're using Windows PowerShell 5.1
            filetypes = {
                "ps1",
                "psm1",
            },
            settings = {
                powershell = {
                    codeFormatting = {
                        openBraceOnSameLine = true,
                        newLineAfterCloseBrace = true,
                    },
                },
            },
        })
    end,

    ["omnisharp"] = function()
        require('lspconfig').omnisharp.setup({
            capabilities = lsp_capabilities,
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            settings = {
                csharp = {
                    enableInlayHintsForImplicitObjectCreation = true,
                    enableInlayHintsForImplicitVariableTypes = true,
                    enableInlayHintsForLambdaParameterTypes = true,
                    enableInlayHintsForTypes = true,
                },

                omnisharp = {
                    enableAsyncCompletion = true,
                    enableDecompilationSupport = true,
                    enableEditorConfigSupport = true,
                    organizeImportsOnFormat = true,
                },
            },
        })
    end,

    ["yamlls"] = function()
        require('lspconfig').yamlls.setup({
            capabilities = lsp_capabilities,
        })
    end,

    ["azure_pipelines_ls"] = function()
        require('lspconfig').azure_pipelines_ls.setup({
            capabilities = lsp_capabilities,
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

    ["gopls"] = function()
        require('lspconfig').gopls.setup({
            capabilities = lsp_capabilities,
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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(event)
        local diagnostic_float = {
            width = 50
        }

        local diagnostic_goto_prefs = {
            float = diagnostic_float,
        }

        vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
            { buffer = event.buf, desc = "[g]o to [d]efinition" })

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
            { buffer = event.buf, desc = "Show hover" })

        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
            { buffer = event.buf, desc = "[v]iew [w]orkspace [s]ymbol" })

        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float(diagnostic_float) end,
            { buffer = event.buf, desc = "[v]iew [d]iagnostic float" })

        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next(diagnostic_goto_prefs) end,
            { buffer = event.buf, desc = "next [d]iagnostic" })

        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev(diagnostic_goto_prefs) end,
            { buffer = event.buf, desc = "previous [d]iagnostic" })

        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
            { buffer = event.buf, desc = "[v]iew [c]ode [a]ction" })

        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
            { buffer = event.buf, desc = "[v]ariable [r]efe[r]ences" })

        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
            { buffer = event.buf, desc = "[v]ariable [r]e[n]ame" })

        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
            { buffer = event.buf, desc = "signature [h]elp" })
    end,
})
