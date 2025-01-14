local M = {}

M.mappings = {
    preset = 'none',
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<Return>'] = { 'accept', 'fallback' },
    ['<C-s>'] = { 'show' },
    ['<C-j>'] = {
        function(cmp) cmp.scroll_documentation_up(4) end,
        'fallback',
    },
    ['<C-k>'] = {
        function(cmp) cmp.scroll_documentation_down(4) end,
        'fallback'
    },
    ['<C-d>'] = { function(cmp) cmp.show({ providers = { 'copilot' } }) end },
}

return M
