-- lazy.nvim bootstrap
local opts = require("plugins.configs.lazy_nvim")
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

local plugins = {

	-- FIND IF IT REALLY WORKS
	-- open large files fast
	{
		"vim-scripts/LargeFile",
		init = function() end, -- necessary because plugin does not have a setup function
		cond = function()
			local filepath = vim.fn.expand("%")
			local filesize = vim.fn.getfsize(filepath) / (1024 * 1024)
			local max_filesize = 5 -- megabytes

			if filesize > max_filesize then
				vim.g.LargeFile = max_filesize -- plugin minimum file size to run
				return true
			end
		end,
	},

	-- lua library
	"nvim-lua/plenary.nvim",

	-- manage LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		cmd = { "Mason", "MasonInstall", "MasonLog", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			require("plugins.configs.mason")
		end,
	},

	-- integration between lspconfig and mason
	{
		"williamboman/mason-lspconfig.nvim",
		init = function()
			vim.schedule(function()
				require("lazy").load({ plugins = "mason-lspconfig.nvim" })
				vim.cmd("silent! do FileType")
			end, 0)
		end,
		opts = function()
			require("plugins.configs.mason-lspconfig")
		end,
	},

	-- inject LSP diagnostics, code actions, and more
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.null-ls")
		end,
	},

	-- integration between mason and null-ls
	{
		"jayp0521/mason-null-ls.nvim",
		cmd = "NullLsInstall",
		build = ":NullLsInstall",
		opts = { automatic_installation = true },
	},

	-- EDIT CONFIG FILE
	-- language server protocol
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.nvim-lspconfig")
		end,
	},

	-- parser generator (highlight, folding etc)
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = function()
			require("plugins.configs.nvim-treesitter")
		end,
	},

	-- show code context
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		opts = function()
			require("plugins.configs.nvim-treesitter-context")
		end,
	},

	-- completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- cmp sources
			"saadparwaiz1/cmp_luasnip", -- luasnip completion
			"hrsh7th/cmp-nvim-lua", -- neovim Lua API
			"hrsh7th/cmp-nvim-lsp", -- neovim builtin LSP client
			"hrsh7th/cmp-buffer", -- buffer words
			"hrsh7th/cmp-path", -- complete paths
			"f3fora/cmp-spell", -- spell checking
			"hrsh7th/cmp-calc", -- math calculation
			"hrsh7th/cmp-emoji",

			-- ai completion
			{
				"Exafunction/codeium.nvim",
				config = function()
					require("codeium").setup({})
				end,
			},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},

	-- snippets engine
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = "rafamadriz/friendly-snippets", -- snippets library
		config = function()
			require("plugins.configs.luasnip")
		end,
	},

	-- auto close pairs (), [], {}, "", ''
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.nvim-autopairs")
		end,
	},

	-- lsp hint as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.lsp_signature")
		end,
	},

	-- font icons
	{
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
	},

	-- REVIEW CODE
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("plugins.configs.lualine")
		end,
		-- needs to be loaded as a dependency so it does not overwrite lualine theme
		dependencies = {
			{
				"projekt0n/github-nvim-theme",
				opts = {
					options = {
						transparent = true,
						module_default = false,
						darken = {
							floats = false,
							sidebars = { enable = false },
						},
						styles = {
							comments = "italic",
							keywords = "italic",
						},
						modules = {
							gitsigns = false,
						},
					},
				},
				config = function()
					vim.cmd("colorscheme github_light_high_contrast")
				end,
			},
		},
	},

	-- breadcrumbs
	{
		"SmiteshP/nvim-navic",
		event = "VeryLazy",
		opts = { lsp = { auto_attach = true, preference = nil }, click = true },
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugins.configs.telescope")
		end,
	},

	-- telescope file browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope file_browser",
	},

	-- auto close/rename tag
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			vim.cmd("TSEnable autotag")
		end,
	},

	-- easy motion
	{
		"phaazon/hop.nvim",
		branch = "v2",
		cmd = "HopChar1",
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},

	-- add, replace and remove surround characters
	{
		"ur4ltz/surround.nvim",
		event = "InsertEnter",
		opts = { mappings_style = "sandwich" },
	},

	-- comment code blocks
	{
		lazy = false,
		"numToStr/Comment.nvim",
		opts = { toggler = { line = "gcc", block = "gbc" } },
	},

	-- change commentstring according to the lang
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"tsx",
			"jsx",
			"php",
			"css",
			"scss",
		},
	},

	-- add support to editorconfig
	{
		"gpanders/editorconfig.nvim",
		event = "VeryLazy",
	},

	-- get the node type under the cursor
	{ "roobert/node-type.nvim" },

	-- handle csv files
	{
		"cameron-wags/rainbow_csv.nvim",
		config = function()
			require("rainbow_csv").setup()
		end,
		ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe", "rfc_csv", "rfc_semicolon" },
		cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted", "RainbowMultiDelim" },
	},

	-- show colors code on the document
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()

			-- execute colorizer as soon as possible
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)
		end,
	},

	-- highligh other uses of the word under the cursor
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.illuminate")
		end,
	},

	-- git symbols (added, deleted, changed) in the signcolumn
	{
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		init = function()
			-- load gitsigns only when a git file is opened
			vim.api.nvim_create_autocmd({ "BufRead" }, {
				group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
				callback = function()
					vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
					if vim.v.shell_error == 0 then
						vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
						vim.schedule(function()
							require("lazy").load({ plugins = { "gitsigns.nvim" } })
						end)
					end
				end,
			})
		end,
		opts = function()
			require("plugins.configs.gitsigns")
		end,
	},

	-- indent lines guides
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		config = function()
			require("plugins.configs.indent-blankline")
		end,
	},

	-- HIDE top dir path
	-- sidebar file navigation
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		version = "*",
		opts = function()
			require("plugins.configs.nvim-tree")
		end,
	},

	-- personal wiki
	{
		"vimwiki/vimwiki",
		cmd = { "VimwikiIndex", "VimwikiDiaryIndex" },
		init = function()
			require("plugins.configs.vimwiki")
		end,
	},

	-- discord rich presence
	-- {
	-- 	"andweeb/presence.nvim",
	-- 	event = "VeryLazy",
	-- 	cond = function()
	-- 		local is_discord_running = vim.fn.systemlist("pgrep -x Discord")
	-- 		if is_discord_running[1] then
	-- 			return true
	-- 		end
	-- 	end,
	-- },

	-- qml syntax highlighting
	{
		"peterhoeg/vim-qml",
		ft = "qml",
	},

	{
		"tikhomirov/vim-glsl",
		ft = "glsl",
	},
}

require("lazy").setup(plugins, opts)
