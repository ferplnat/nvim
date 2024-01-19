--- @type LazyPluginSpec
return {
    name = 'copilot',
    [1] = 'zbirenbaum/copilot.lua',
    version = '*',
    config = function()
        local remaps = require('marco.remaps.copilot')
        require('copilot').setup({
            panel = {
                enabled = true,
            },

            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = remaps.suggestion_maps,
            },

            filetypes = {
                yaml = true,
                markdown = true,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
                oil = false,
            },

            copilot_node_command = 'node', -- Node.js version must be > 16.x
            server_opts_overrides = {},
        })

        remaps.apply()
    end,
}
