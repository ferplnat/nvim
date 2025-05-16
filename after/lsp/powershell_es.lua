local powershell_cmd = vim.fn.getenv('PSCMD') or 'powershell'

--- @type vim.lsp.Config
return {
    shell = powershell_cmd,
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
}
