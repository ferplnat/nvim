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

        local function find_fallback()
            if pcall(builtin.git_files) then
                return
            elseif pcall(builtin.find_files) then
                return
            end
        end

        require('telescope').setup({
            extensions = {
                ["ui-select"] = {
                    themes.get_cursor(),
                },

                ["cmdline"] = {
                    picker = {
                        layout_config = {
                            width  = 120,
                            height = 25,
                        },
                    },
                    mappings = {
                        complete      = '<Tab>',
                        run_selection = '<C-CR>',
                        run_input     = '<CR>',
                    },
                },
            },

            pickers = {
                --        builtin = {
                --            theme = "cursor",
                --            previewer = false,
                --        },
            },
        })

        require("telescope").load_extension("ui-select")
        require('plenary.filetype').add_file('ps1')

        vim.keymap.set('n', '<C-p>', find_fallback, {})
        vim.keymap.set('n', '<leader>t', builtin.builtin, {})
        vim.keymap.set('n', '<leader>pt', builtin.treesitter, {})
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

        vim.api.nvim_create_user_command('TGBranches', builtin.git_branches, {})
        vim.api.nvim_create_user_command('TGCommits', builtin.git_commits, {})
        vim.api.nvim_create_user_command('TGStatus', builtin.git_status, {})
        vim.api.nvim_create_user_command('TGStash', builtin.git_stash, {})
    end,
}
