return function(capabilities, on_attach)
    require('lspconfig').yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
