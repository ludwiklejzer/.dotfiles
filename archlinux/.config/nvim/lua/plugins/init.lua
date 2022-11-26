local packer = require("packer")

return packer.startup(function(use)
	-- manage LSP servers, DAP servers, linters, and formatters
	use({
		"williamboman/mason.nvim",
		config = function()
			require("plugins.configs.mason")
		end,
	})

	-- integration between lspconfig and mason
	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	})

	-- inject LSP diagnostics, code actions, and more
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("plugins.configs.null-ls")
		end,
	})

	-- integration between mason and null-ls
	use({
		"jayp0521/mason-null-ls.nvim",
		config = function()
			require("plugins.configs.mason-null-ls")
		end,
	})

	-- language server protocol
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.nvim-lspconfig")
		end,
	})

	-- snippets library
	use({
		"rafamadriz/friendly-snippets",
		module = "cmp_nvim_lsp",
		event = "InsertEnter",
	})

	-- completion engine
	use({
		"hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("plugins.configs.cmp")
		end,
	})

	-- snippets engine
	use({
		"L3MON4D3/LuaSnip",
		tag = "v<CurrentMajor>.*",
		wants = "friendly-snippets",
		after = "nvim-cmp",
		config = function()
			require("plugins.configs.luasnip")
		end,
	})

	-- luasnip completion source for nvim-cmp
	use({
		"saadparwaiz1/cmp_luasnip",
		after = "LuaSnip",
	})

	-- nvim-cmp source for neovim Lua API
	use({
		"hrsh7th/cmp-nvim-lua",
		after = "cmp_luasnip",
	})

	-- nvim-cmp source for neovim builtin LSP client
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "cmp-nvim-lua",
	})

	-- nvim-cmp source for buffer words
	use({
		"hrsh7th/cmp-buffer",
		after = "cmp-nvim-lsp",
	})

	-- nvim-cmp source for paths
	use({
		"hrsh7th/cmp-path",
		after = "cmp-buffer",
	})

	-- nvim-cmp source for spell checking
	use({
		"f3fora/cmp-spell",
		after = "cmp-path",
	})

	-- nvim-cmp source for math calculation
	use({
		"hrsh7th/cmp-calc",
		after = "cmp-spell",
	})

	-- auto close pairs (), [], {}, "", ''
	use({
		"windwp/nvim-autopairs",
		after = "cmp-calc",
		config = function()
			require("plugins.configs.nvim-autopairs")
		end,
	})

	-- lsp hint as you type
	use({
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.lsp_signature")
		end,
	})

	-- parser generator (highlight, folding etc)
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("plugins.configs.nvim-treesitter")
		end,
	})

	-- auto close/rename tag
	use({
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup({ enable = true })
		end,
	})

	-- change commentstring according to the lang
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "InsertEnter",
	})

	-- lua library
	use({
		"nvim-lua/plenary.nvim",
		module = "plenary",
	})

	-- popup nvim implementation
	use({
		"nvim-lua/popup.nvim",
		module = "popup",
	})

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		config = function()
			require("plugins.configs.telescope")
		end,
	})

	-- git symbols (added, deleted, changed) in the signcolumn
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	})

	-- statusline
	use({
		"feline-nvim/feline.nvim",
		config = function()
			require("plugins.configs.feline")
		end,
	})

	-- buffers listed like tabs
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.configs.bufferline")
		end,
	})

	-- icons
	use({
		"kyazdani42/nvim-web-devicons",
		module = "nvim-web-devicons",
	})

	-- sidebar file navigation
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("plugins.configs.nvim-tree")
		end,
	})

	-- hide screen elements
	use({
		"Pocco81/TrueZen.nvim",
		cmd = { "TZAtaraxis" },
	})

	-- comment code blocks
	use({
		"terrortylor/nvim-comment",
		cmd = { "CommentToggle" },
		config = function()
			require("nvim_comment").setup({ comment_empty = false })
		end,
	})

	-- indent lines guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.configs.indent_blankline")
		end,
	})

	-- add, replace and remove surround characters
	use({
		"ur4ltz/surround.nvim",
		event = "InsertEnter",
		config = function()
			require("surround").setup({ mappings_style = "sandwich" })
		end,
	})

	-- discord rich presence
	use({
		"andweeb/presence.nvim",
		event = "InsertEnter",
	})

	-- colors based on wallpaper
	use({
		"AlphaTechnolog/pywal.nvim",
		as = "pywal",
		config = function()
			-- require('pywal').setup()
			require("plugins.configs.custom_colors")
		end,
	})

	use({
		"atalazer/wally.nvim",
		run = "./setup.sh",
		config = function()
			vim.g.wally_wal_dir = "~/.cache/wal"
			vim.g.wally_italic_comments = true
			vim.g.wally_italic_variables = false
			vim.g.wally_italic_keywords = true
			vim.g.wally_italic_functions = false
			vim.g.wally_sidebars = { "qf", "vista_kind", "terminal", "Nvimtree", "Trouble", "packer" }
			require("wally").colorscheme()
			require("plugins.configs.custom_colors")
		end,
	})

	-- open large files fast
	use({
		"vim-scripts/LargeFile",
	})

	-- personal wiki
	use({
		"vimwiki/vimwiki",
		setup = function()
			require("plugins.configs.vimwiki")
		end,
		cmd = { "VimwikiIndex", "VimwikiDiaryIndex" },
	})

	-- easy motion
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		cmd = "HopChar1",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- show colors code on the document
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("plugins.configs.dap")
		end,
	})

	use({
		"jayp0521/mason-nvim-dap.nvim",
		config = function()
			require("plugins.configs.mason-nvim-dap")
		end,
	})

	use({
		"peterhoeg/vim-qml",
	})
end)
