--- @type vim.lsp.Config
return {
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
}

