local builtins = require('null-ls.builtins')
require('null-ls').setup({
    sources = {
        builtins.diagnostics.alex
    }
})
