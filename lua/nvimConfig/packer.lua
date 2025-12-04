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
		requires = {'nvim-lua/plenary.nvim'}
	}
	use('nvim-telescope/telescope-ui-select.nvim')

	--here are some themes i use

	use { 'projekt0n/github-nvim-theme' }
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use('morhetz/gruvbox')
	use('catppuccin/nvim')
	use('folke/tokyonight.nvim')

	-- -- for gdb(vimspector)
	-- use{'puremourning/vimspector'}
	use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
	use('theHamsta/nvim-dap-virtual-text')

	--this is for nerdtree
	use { 'preservim/nerdtree' }

	--this is for icons in nerd tree
	use { 'ryanoasis/vim-devicons' }

	--for treesitter
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	--for undo tree
	use('mbbill/undotree')

	-- for lsps
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }
	use { 'hrsh7th/nvim-cmp' }

	--for code snippets

	use { 'L3MON4D3/LuaSnip' }
	use { 'saadparwaiz1/cmp_luasnip' }
	use { 'rafamadriz/friendly-snippets' }

	--- github copilot
	use { 'github/copilot.vim' }

	use({
		"CopilotC-Nvim/CopilotChat.nvim",
		requires = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" }
		},
		run = "make tiktoken" -- Optional: builds tiktoken for token counting
	})


	--for indent lines
	use { 'lukas-reineke/indent-blankline.nvim' }

	--for tagbar
	use { 'preservim/tagbar' }

	--for latex<
	use('lervag/vimtex')

	-- for comment
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	use { "tpope/vim-fugitive" }

	--for toggleterm
	use { "akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end }

	-- to generate function descriptions
	use {
		"danymat/neogen",
		config = function()
			require('neogen').setup {}
		end,
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	}

	-- hardtime(to be removed later)
	-- use('m4xshen/hardtime.nvim')

	-- for surrounding things
	use('tpope/vim-surround')

	-- for inlay hints at the end of line
	use {
		"chrisgrieser/nvim-lsp-endhints",
		config = function()
			require("lsp-endhints").setup {
				icons = {
					type = "󰜁 ",
					parameter = "󰏪 ",
					offspec = " ", -- hint kind not defined in official LSP spec
					unknown = " ", -- hint kind is nil
				},
				label = {
					truncateAtChars = 20,
					padding = 1,
					marginLeft = 0,
					sameKindSeparator = ", ",
				},
				autoEnableHints = true,
			}
		end }

	-- for markdown rendering
	-- use({
	-- 	'MeanderingProgrammer/render-markdown.nvim',
	-- 	after = { 'nvim-treesitter' },
	-- 	config = function()
	-- 		require('render-markdown').setup({})
	-- 	end,
	-- })
	-- for competitive programming
	-- use {
	-- 'xeluxee/competitest.nvim',
	-- 	requires = 'MunifTanjim/nui.nvim',
	-- 	config = function() require('competitest').setup() end
	-- }
end)
