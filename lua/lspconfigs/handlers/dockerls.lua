return function(capabilities, on_attach)
    local utils = require('marco.utils')

    on_attach = utils.extend_func(on_attach, function()
        vim.highlight.priorities.semantic_tokens = 105
    end)

    require('lspconfig').dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
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
    })
end
