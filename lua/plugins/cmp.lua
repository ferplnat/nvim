--- @type LazyPluginSpec
return {
    name = 'cmp',
    [1] = 'hrsh7th/nvim-cmp',

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',
    },

    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local remaps = require('marco.remaps.cmp')
        require("luasnip.loaders.from_vscode").lazy_load()

        local insert_completion_sources = {
            { name = 'nvim_lsp_signature_help', group_index = 2 },
            { name = 'nvim_lsp',                group_index = 2, priority = 1 },
            { name = 'luasnip',                 group_index = 2, priority = 2 },
            { name = 'nvim_lua',                group_index = 3, priority = 2 },
            { name = 'buffer',                  group_index = 3, priority = 2 },
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            window = {
                documentation = {
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None'
                },
            },

            preselect = cmp.PreselectMode.None,

            mapping = remaps.mappings,

            sources = insert_completion_sources
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    { name = 'path',    group_index = 1 },
                    { name = 'cmdline', group_index = 2 },
                })
        })
    end,
}
