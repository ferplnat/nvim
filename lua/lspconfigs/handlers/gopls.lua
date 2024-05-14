return function(capabilities, on_attach)
    require('lspconfig').gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    })
end
