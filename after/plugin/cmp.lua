require('copilot_cmp').setup() -- Integrate copilot with cmp
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

local insert_completion_sources = {
    { name = 'nvim_lsp_signature_help', group_index = 2 },
    { name = 'nvim_lsp',                group_index = 2, priority = 1 },
    { name = 'copilot',                 group_index = 2, priority = 2 },
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

    experimental = {
        ghost_text = true,
    },

    window = {
        documentation = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None'
        },
    },

    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Return>'] = cmp.mapping.confirm({ select = false }),
        ["<C-s>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                fallback()
                -- expand_or_locally_jumpable() is used to avoid errant jumps outside of luasnip regions
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                fallback()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

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
