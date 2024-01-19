local M = {}

local cmp_select = { behavior = require('cmp').SelectBehavior.Select }

M.mappings = {
    ['<Up>'] = require('cmp').mapping.select_prev_item(cmp_select),
    ['<Down>'] = require('cmp').mapping.select_next_item(cmp_select),
    ['<Return>'] = require('cmp').mapping.confirm({ select = false }),
    ['<C-s>'] = require('cmp').mapping.complete(),
    ['<C-j>'] = require('cmp').mapping.scroll_docs(-4),
    ['<C-k>'] = require('cmp').mapping.scroll_docs(4),
    ['<Tab>'] = require('cmp').mapping(function(fallback)
        if require('cmp').visible() then
            fallback()
            -- expand_or_locally_jumpable() is used to avoid errant jumps outside of luasnip regions
        elseif require('luasnip').expand_or_locally_jumpable() then
            require('luasnip').expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),

    ['<S-Tab>'] = require('cmp').mapping(function(fallback)
        if require('cmp').visible() then
            fallback()
        elseif require('luasnip').locally_jumpable(-1) then
            require('luasnip').jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
}

return M
