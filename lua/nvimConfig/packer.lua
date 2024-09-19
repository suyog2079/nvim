-- This file can be loaded by calling `lua require('plugins')` from your init.vim
--

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	--here are some themes i use

	use { 'projekt0n/github-nvim-theme' }

--this is the theme
use("vim-airline/vim-airline")
use('morhetz/gruvbox')
use('catppuccin/catppuccin')

--this is for nerdtree
use {'preservim/nerdtree'}

--this is for icons in nerd tree
use {'ryanoasis/vim-devicons'}

--for treesitter
use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
use ('nvim-treesitter/playground')

--for harpoon
use('ThePrimeagen/harpoon')
--for undo tree
use('mbbill/undotree')
--for git apparently
use('tpope/vim-fugitive')

-- for lsps
use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}


use{'hrsh7th/cmp-nvim-lsp'}
use{'hrsh7th/cmp-buffer'}
use{'hrsh7th/cmp-path'}
use{'hrsh7th/cmp-cmdline'}
use{'hrsh7th/nvim-cmp'}


--for telescope ui again(this time it gives nice little window for code actions)

use('nvim-telescope/telescope-ui-select.nvim')

--for code snippets

use{'L3MON4D3/LuaSnip'}
use{'saadparwaiz1/cmp_luasnip'}
use{'rafamadriz/friendly-snippets'}

--for indent lines
use{'lukas-reineke/indent-blankline.nvim'}
--for tagbar
use{'preservim/tagbar'}

--for latex<
use('lervag/vimtex')

--for bufferline
use('akinsho/bufferline.nvim')

end)
