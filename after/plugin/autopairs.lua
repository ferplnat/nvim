require("nvim-autopairs").setup {}

-- Autopairs
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = require('nvim-autopairs.completion.handlers')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({
        filetypes = {

            ["*"] = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Function,
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers["*"]
                }
            },

            ["ps1"] = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers["*"]
                }
            },

            ["psm1"] = {
                ["("] = {
                    kind = {
                        cmp.lsp.CompletionItemKind.Method,
                    },
                    handler = handlers["*"]
                }
            },

        }
    })
)

