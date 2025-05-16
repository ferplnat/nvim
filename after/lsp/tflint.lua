--- @type vim.lsp.Config
return {
    cmd = { 'tflint', '--langserver', '--format', 'json' },
    filetypes = { 'terraform' },
    root_pattern = {
        '.terraform',
        '.git',
        '.tflint.hcl',
    },
}
