return function(capabilities, on_attach)
    require('lspconfig').lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
            },
        },
    }
end
