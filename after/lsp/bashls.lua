--- @type vim.lsp.Config
return {
    cmd = { 'bash-language-server', 'start' },
    filetypes = {
        "sh",
        "bash",
        "zsh",
    },
    settings = {
        bashIde = {
            shellcheckPath = require('marco.utils').get_mason_package_path('shellcheck'),
            shfmt = {
                path = require('marco.utils').get_mason_package_path('shfmt'),
            },
        },
    },
}
