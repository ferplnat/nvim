local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- MY PLUGINS!!!
    'ferplnat/truefalse.nvim',

    -- NEOVIM API STUFF --
    { 'folke/neodev.nvim',    version = "*" },

    -- COLORS --
    'loctvl842/monokai-pro.nvim',
    'rebelot/kanagawa.nvim',
    -- END COLORS --

    -- FILE/WORKSPACE MANAGEMENT STUFF --
    -- COPILOT
    {
        'zbirenbaum/copilot-cmp',
        dependencies = {
            {
                'zbirenbaum/copilot.lua',
                version = '*',
            }
        },
        version = '*',
    },

    -- TELESCOPE
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    -- HARPOON
    { 'ThePrimeagen/harpoon', dependencies = { { 'nvim-lua/plenary.nvim' } } },

    -- TREESITTER
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',

    -- BETTER TERMINAL EXPERIENCE
    { 'akinsho/toggleterm.nvim',     version = "*" },

    -- UNDOTREE
    'mbbill/undotree',

    -- GIT INTEGRATION
    'tpope/vim-fugitive',

    -- MAKE NETRW A LITTLE LESS SUCK
    'tpope/vim-vinegar',
    -- END FILE/WORKSPACE MANAGEMENT STUFF --

    -- UTILITIES/QUALITY OF LIFE IMPROVEMENTS --
    -- NO NECK PAIN
    { 'shortcuts/no-neck-pain.nvim', version = "*" },

    -- Diff Visual Selection (LineDiff)
    'AndrewRadev/linediff.vim',

    -- INDENT GUIDES --
    { 'lukas-reineke/indent-blankline.nvim', version = "*" },

    -- AutoPairs
    'windwp/nvim-autopairs',

    -- Surround
    'kylechui/nvim-surround',

    -- Formatting
    'mhartington/formatter.nvim',
    -- END UTILITIES/QUALITY OF LIFE IMPROVEMENTS --

    -- LSP, COMPLETION, SNIPPETS --
    -- LSP Stuff
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
        'neovim/nvim-lspconfig',
        commit = '27c5947'
    },

    -- Completion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    -- LuaSnip
    {
        "L3MON4D3/LuaSnip",
        version = "*",

        -- install jsregexp.
        build = "make install_jsregexp",
    },

    'rafamadriz/friendly-snippets', -- Snippet library
    'saadparwaiz1/cmp_luasnip',
    -- END LSP, COMPLETION, SNIPPETS --

    -- Vim tutorials
    'ThePrimeagen/vim-be-good',
})
