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
    table.insert(ensure_installed, 'omnisharp@v1.39.8') -- 1.39.10 is broken; 1.39.9 is worse.
end

-- neodev needs to be called before lspconfig
require("neodev").setup({})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local my_onattach = function(client, bufnr)
    local diagnostic_float = {
        width = 50
    }

    local diagnostic_goto_prefs = {
        float = diagnostic_float,
    }

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = "[g]o to [d]efinition" })

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
        { buffer = bufnr, desc = "Show hover" })

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
        { buffer = bufnr, desc = "[v]iew [w]orkspace [s]ymbol" })

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float(diagnostic_float) end,
        { buffer = bufnr, desc = "[v]iew [d]iagnostic float" })

    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next(diagnostic_goto_prefs) end,
        { buffer = bufnr, desc = "next [d]iagnostic" })

    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev(diagnostic_goto_prefs) end,
        { buffer = bufnr, desc = "previous [d]iagnostic" })

    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, desc = "[v]iew [c]ode [a]ction" })

    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = "[v]ariable [r]efe[r]ences" })

    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
        { buffer = bufnr, desc = "[v]ariable [r]e[n]ame" })

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = "signature [h]elp" })

    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider = nil
    end
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
        require('lspconfig').omnisharp.setup({
            capabilities = lsp_capabilities,
            on_attach = my_onattach,
            handlers = {
                ["textDocument/definition"] = require('omnisharp_extended').handler,
            },
            settings = require('marco.lspconfigs.omnisharp').settings,
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
