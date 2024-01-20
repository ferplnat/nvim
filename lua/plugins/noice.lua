--- @type LazyPluginSpec
return {
    name = 'noice',
    [1] = 'folke/noice.nvim',

    event = 'VeryLazy',

    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },

    config = function()
        require('noice').setup({
            lsp = {
                progress = {
                    enabled = true,
                    format = 'lsp_progress',
                    format_done = 'lsp_progress_done',
                    view = 'mini',
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            cmdline = {
                format = {
                    opts = {
                        position = '50%',
                    },
                    cmdline = false,
                    search_down = false,
                    search_up = false,
                    filter = false,
                    lua = false,
                    help = false,
                },
            },
            messages = {
                view_search = false,
            },
            message = {
                enabled = true,
                view = 'notify',
            },
            popupmenu = {
                enabled = true,
                backend = 'cmp',
            },
        })
    end,
}
