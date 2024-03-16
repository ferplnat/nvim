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
            'cpp',
            'css',
            'csv',
            'c_sharp',
            'comment', -- TODO: and NOTE: FIXME: etc
            'diff',
            'dockerfile',
            'gitcommit',
            'gitignore',
            'git_config',
            'git_rebase',
            'go',
            'gomod',
            'gosum',
            'gowork',
            'html',
            'json',
            'lua',
            'luadoc',
            'markdown',
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

        if jit.os == 'Windows' and vim.fn.isdirectory(vim.fn.expand('~/nvim_parsers/tree-sitter-powershell')) == 1 then
            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

            parser_config.powershell = {
                install_info = {
                    url = "https://github.com/airbus-cert/tree-sitter-powershell",
                    files = { "src/parser.c", "src/scanner.c" },
                },
                filetype = "ps1",
            }

            vim.treesitter.language.register('powershell', 'psm1')
            table.insert(ensure_installed, 'powershell')
        end

        local remaps = require('marco.remaps.treesitter')
        remaps.apply()

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
