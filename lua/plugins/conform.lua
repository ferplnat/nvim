--- @module 'lazy.types'
--- @type LazyPluginSpec
return
{
    name = 'conform.nvim',
    [1] = 'stevearc/conform.nvim',

    config = function()
        require('marco.remaps.conform').apply()

        vim.api.nvim_create_user_command('Format', function()
            require('conform').format({ lsp_fallback = true })
        end, {})

        require('conform').setup({
            go = { "gofmt" },
            sh = { "shfmt" },
            ['*'] = { "codespell" },
        })
    end,
}
