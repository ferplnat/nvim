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

    -- COLORS --
    'loctvl842/monokai-pro.nvim',
    'rebelot/kanagawa.nvim',
    -- END COLORS --

    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.2',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/playground',

    { 'akinsho/toggleterm.nvim', version = "*" }, -- Terminal improvements

    'mbbill/undotree', -- UndoTree
    'tpope/vim-fugitive', -- Git
    'tpope/vim-vinegar', -- netrw improvements

    -- Diff Visual Selection (LineDiff)
    'AndrewRadev/linediff.vim',

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

    -- AutoPairs
    'windwp/nvim-autopairs',

    -- Surround
    'kylechui/nvim-surround',

    -- Formatting
    'mhartington/formatter.nvim',

    -- LuaSnip
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

        -- install jsregexp.
        build = "make install_jsregexp",
    },

    'rafamadriz/friendly-snippets', -- Snippet library
    'saadparwaiz1/cmp_luasnip',

    -- Vim tutorials
    'ThePrimeagen/vim-be-good',
})
