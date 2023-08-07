-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  "loctvl842/monokai-pro.nvim",
	  config = function()
		  require("monokai-pro").setup()
	  end
  }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/nvim-treesitter-context')
  use('nvim-treesitter/playground')

  use('mbbill/undotree') -- UndoTree
  use('tpope/vim-fugitive') -- Git
  use('tpope/vim-vinegar') -- netrw improvements

  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })
-- Diff Visual Selection (LineDiff)
  use('AndrewRadev/linediff.vim')

-- LSP Stuff
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('neovim/nvim-lspconfig')

-- Completion
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/nvim-cmp')

-- LuaSnip
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')

  use('ThePrimeagen/vim-be-good')
end)
