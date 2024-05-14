return function(capabilities, on_attach)
    require('lspconfig').bicep.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
