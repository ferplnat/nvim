require('copilot').setup({
    panel = {
        enabled = true,
    },

    suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
            accept = "<C-d>",
            next = "<C-.>",
            prev = "<C-,>",
            dismiss = "<C-y>",
        },
    },

    filetypes = {
        yaml = true,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },

    copilot_node_command = 'node', -- Node.js version must be > 16.x
    server_opts_overrides = {},
})

vim.keymap.set("n", "<leader>cp", require('copilot.panel').open, { desc = "Open [c]opilot [p]anel." })
