--- @type vim.lsp.Config
return {
    settings = {
        docker = {
            languageServer = {
                diagnostics = {
                    deprecatedMaintainer = 'error',
                    directiveCasing = 'error',
                    emptyContinuationLine = 'error',
                    instructionCasing = 'error',
                    instructionCmdMultiple = 'error',
                    instructionEntrypointMultiple = 'error',
                    instructionHealthcheckMultiple = 'error',
                    instructionJSONInSingleQuotes = 'error',
                    instructionWorkdirRelative = 'error',
                },
                formatter = {
                    ignoreMultilineInstructions = true,
                },
            },
        },
    },

}
