return function(capabilities, on_attach)
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
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end
end
