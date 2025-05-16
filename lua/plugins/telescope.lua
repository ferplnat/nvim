--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'telescope',
    [1] = 'nvim-telescope/telescope.nvim',
    version = "*",
    dependencies = {
        {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
    },

    config = function()
        local builtin = require('telescope.builtin')
        local themes = require('telescope.themes')
        local remaps = require('marco.remaps.telescope')

        require('telescope').setup({
            extensions = {
                ["ui-select"] = {
                    themes.get_dropdown(),
                },

                ["cmdline"] = {
                    picker = {
                        layout_config = {
                            width  = 120,
                            height = 25,
                        },
                    },
                    mappings = remaps.cmdline,
                },
            },

            pickers = {
                --        builtin = {
                --            theme = "cursor",
                --            previewer = false,
                --        },
            },
        })

        remaps.apply(builtin)

        if not pcall(require('telescope').load_extension, 'ui-select') then
            vim.api.nvim_notify('Failed to load extension "ui-select"', vim.log.levels.ERROR, { title = "Telescope" })
        end

        if not pcall(require('telescope').load_extension, 'fzf') then
            vim.api.nvim_notify('Failed to load extension "fzf"', vim.log.levels.ERROR, { title = "Telescope" })
        end

        require('plenary.filetype').add_file('extras')
    end,
}
