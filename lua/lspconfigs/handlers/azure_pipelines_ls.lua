return function(capabilities, on_attach)
    require('lspconfig').azure_pipelines_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            yaml = {
                schemas = {
                    ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                        "**azure-devops**.yaml",
                        "**azure-devops**.yaml",
                        "**Azure**.yaml",
                        "**Azure**.yml",
                        "**AzDO**.yml",
                        "**AzDO**.yaml",
                    },
                },
            },
        },
    })
end
