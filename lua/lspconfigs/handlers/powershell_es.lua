return function(capabilities, on_attach)
    local marco_utils = require('marco.utils')
    local powershell_cmd = vim.fn.getenv('PSCMD') or 'powershell'

    require('lspconfig').powershell_es.setup({
        shell = powershell_cmd,
        capabilities = capabilities,
        on_attach = marco_utils.extend_func(on_attach, function()
            vim.cmd.syntax({ args = { 'enable' }, mods = { silent = true } })
        end),
        filetypes = {
            "ps1",
            "psm1",
        },
        single_file_support = true,
        settings = {
            powershell = {
                codeFormatting = {
                    alignPropertyValuePairs = true,
                    addWhitespaceAroundPipe = true,
                    avoidSemicolonsAsLineTerminators = true,
                    openBraceOnSameLine = true,
                    newLineAfterCloseBrace = true,
                    useCorrectCasing = true,
                    useConstantStrings = true,
                },
                scriptAnalysis = {
                    enable = true,
                },
            },
        },
    })
end
