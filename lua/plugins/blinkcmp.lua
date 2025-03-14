--- @type LazyPluginSpec
return {
    name = 'blink.cmp',
    [1] = 'saghen/blink.cmp',
    version = '*',

    dependencies = {
        'copilot',
        'giuxtaposition/blink-cmp-copilot',
    },

    config = function()
        require('blink.cmp').setup({
            keymap = require('marco.remaps.blinkcmp').mappings,

            cmdline = {
                sources = function()
                    local type = vim.fn.getcmdtype()
                    -- Search forward and backward
                    if type == '/' or type == '?' then return { 'buffer' } end
                    -- Commands
                    if type == ':' or type == '@' then return { 'cmdline' } end
                    return {}
                end,
            },

            sources = {
                default = {
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                },


                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },

            completion = {
                trigger = {
                    prefetch_on_insert = true,
                },

                keyword = {
                    range = 'full',
                },

                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                },

                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                },

                ghost_text = {
                    enabled = true,
                },

                menu = {
                    draw = {
                        columns = {
                            {
                                [1] = "label",
                                [2] = "label_description",
                                gap = 1,
                            },
                            {
                                "kind"
                            },
                        },
                    }
                },
            },

            signature = {
                enabled = true,
            },
        })
    end
}
