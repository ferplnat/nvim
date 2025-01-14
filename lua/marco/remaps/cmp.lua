local M = {}

local cmp_select = { behavior = require('cmp').SelectBehavior.Select }

M.mappings = {
    ['<Up>'] = require('cmp').mapping.select_prev_item(cmp_select),
    ['<Down>'] = require('cmp').mapping.select_next_item(cmp_select),
    ['<Return>'] = require('cmp').mapping.confirm({ select = false }),
    ['<C-s>'] = require('cmp').mapping.complete(),
    ['<C-j>'] = require('cmp').mapping.scroll_docs(-4),
    ['<C-k>'] = require('cmp').mapping.scroll_docs(4),
    ['<Leader-l>'] = require('cmp').mapping(function(fallback)
        if require('luasnip').expand_or_locally_jumpable() and not require('cmp').visible() then
            require('luasnip').expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),

    ['<Leader-h>'] = require('cmp').mapping(function()
        if require('luasnip').expand_or_locally_jumpable() and not require('cmp').visible() then
            require('luasnip').jump(-1)
        end
    end, { "i", "s" }),

    ['<C-d>'] = require('cmp').mapping(function()
        if require('cmp').visible() then
            require('cmp').close()
            require('cmp').abort()
        end

        require('cmp').complete({
            config = {
                sources = {
                    { name = 'copilot', group_index = 1 }
                }
            }
        }, { "i", "s", })
    end),
}

return M
