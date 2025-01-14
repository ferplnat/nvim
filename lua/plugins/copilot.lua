--- @type LazyPluginSpec
return {
    name = 'copilot',
    [1] = 'zbirenbaum/copilot.lua',

    config = function()
        local remaps = require('marco.remaps.copilot')
        require('copilot').setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = false,
                auto_trigger = false,
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
