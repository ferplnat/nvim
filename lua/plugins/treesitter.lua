--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'treesitter',
    [1] = 'nvim-treesitter/nvim-treesitter',

    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },

    build = ":TSUpdate",

    config = function()
        local ensure_installed = {
            'bash',
            'bicep',
            'c',
            'c_sharp',
            'comment', -- TODO: and NOTE: FIXME: etc
            'cpp',
            'css',
            'csv',
            'diff',
            'dockerfile',
            'git_config',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'go',
            'gomod',
            'gosum',
            'gowork',
            'html',
            'json',
            'lua',
            'luadoc',
            'markdown',
            'powershell',
            'python',
            'regex',
            'sql',
            'ssh_config',
            'terraform',
            'toml',
            'tsv',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
        }

        local remaps = require('marco.remaps.treesitter')
        remaps.apply()

        -- Let treesitter take precedence over semantic token highlighting as it
        -- is usually more granular.
        -- Override in lsp on_attach if this isn't desired.
        vim.hl.priorities.semantic_tokens = 95

        require('nvim-treesitter.configs').setup({
            ensure_installed = ensure_installed,
            sync_install = false,
            auto_install = true,
            modules = {},
            ignore_install = {},

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = remaps.incremental_selection,
            },

            indent = {
                enable = false,
                -- disable = {"python"}
            },

            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = remaps.select,
                },
                swap = {
                    enable = true,
                    swap_next = remaps.swap.swap_next,
                    swap_previous = remaps.swap.swap_previous,
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = remaps.move.goto_next_start,
                    goto_next_end = remaps.move.goto_next_end,
                    goto_previous_start = remaps.move.goto_previous_start,
                    goto_previous_end = remaps.move.goto_previous_end,
                },
            },
        })
    end,
}
