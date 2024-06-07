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
        require("telescope").load_extension("ui-select")

        require('plenary.filetype').add_file('bicep')
        require('plenary.filetype').add_file('fastbuild')
        require('plenary.filetype').add_file('ps1')
        require('plenary.filetype').add_file('terraform')
    end,
}
