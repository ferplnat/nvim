return function(capabilities, on_attach)
    require('lspconfig').bashls.setup({
        cmd = { 'bash-language-server', 'start' },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            bashIde = {
                shellcheckPath = require('marco.utils').get_mason_package_path('shellcheck'),
                shfmt = {
                    path = require('marco.utils').get_mason_package_path('shfmt'),
                },
            },
        },
    })
end
