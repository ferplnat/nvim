local function remove_trailing_whitespace()
    vim.cmd([[silent! :keeppatterns %s/\[ \t]+$//ge]])
end

require('formatter').setup({
    logging = true,
    filetype = {
        ["go"] = {
            function()
                if not vim.fn.executable('gofmt') then
                    print('gofmt is not installed! Please install it to use this formatter.')
                    return
                end

                return {
                    exe = 'gofmt',
                    stdin = true,
                }
            end
        },

        ["*"] = {
            remove_trailing_whitespace,
            function()
                vim.lsp.buf.format({ async = false })
            end
        },
    }
})
