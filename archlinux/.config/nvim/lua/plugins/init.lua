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

	-- lua library
	"nvim-lua/plenary.nvim",

	-- manage LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		config = function()
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
		config = function()
			local servers = vim.tbl_keys(require("lspconfig.configs"))
			require("mason-lspconfig").setup({
				-- ensure_installed = servers,
			})
		end,
	},

	-- inject LSP diagnostics, code actions, and more
	{
		"jose-elias-alvarez/null-ls.nvim",
		init = function()
			vim.schedule(function()
				require("lazy").load({ plugins = "null-ls.nvim" })
			end, 0)
		end,
		config = function()
			require("plugins.configs.null-ls")
		end,
	},

	-- integration between mason and null-ls
	{
		"jayp0521/mason-null-ls.nvim",
		cmd = "NullLsInstall",
		build = ":NullLsInstall",
		config = function()
			require("mason-null-ls").setup({
				automatic_installation = true,
			})
		end,
	},

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
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.nvim-treesitter")
		end,
	},

	-- completion engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- snippets engine
			{
				"L3MON4D3/LuaSnip",
				version = "<CurrentMajor>.*",
				build = "make install_jsregexp",
				dependencies = "rafamadriz/friendly-snippets", -- snippets library
				config = function()
					require("plugins.configs.luasnip")
				end,
			},

			-- auto close pairs (), [], {}, "", ''
			{
				"windwp/nvim-autopairs",
				config = function()
					require("plugins.configs.nvim-autopairs")
				end,
			},

			-- cmp sources
			"saadparwaiz1/cmp_luasnip", -- luasnip completion
			"hrsh7th/cmp-nvim-lua", -- neovim Lua API
			"hrsh7th/cmp-nvim-lsp", -- neovim builtin LSP client
			"hrsh7th/cmp-buffer", -- buffer words
			"hrsh7th/cmp-path", -- complete paths
			"f3fora/cmp-spell", -- spell checking
			"hrsh7th/cmp-calc", -- math calculation
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},

	-- font icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		init = function()
			vim.schedule(function()
				require("lazy").load({ plugins = "lualine.nvim" })
			end, 0)
		end,
		config = function()
			require("plugins.configs.lualine")
		end,
	},

	-- fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugins.configs.telescope")
		end,
	},

	-- file browser
	{
		"nvim-telescope/telescope-file-browser.nvim",
		cmd = "Telescope file_browser",
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
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},

	-- sidebar file navigation
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		version = "*",
		config = function()
			require("plugins.configs.nvim-tree")
		end,
	},

	-- indent lines guides
	{
		"lukas-reineke/indent-blankline.nvim",
		init = function()
			vim.schedule(function()
				require("lazy").load({ plugins = "indent-blankline.nvim" })
			end, 0)
		end,
		config = function()
			require("plugins.configs.indent-blankline")
		end,
	},

	-- hide screen elements
	{
		"Pocco81/TrueZen.nvim",
		cmd = { "TZAtaraxis" },
		config = function()
			require("true-zen").setup({
				modes = {
					ataraxis = {
						callbacks = {
							close_pos = function()
								require("lualine").hide({ unhide = true })
								vim.wo.linebreak = false
								vim.wo.wrap = false
							end,
							open_pre = function()
								require("lualine").hide()
								vim.wo.linebreak = true
								vim.wo.wrap = true
							end,
						},
					},
				},
			})
		end,
	},

	-- comment code blocks
	{
		"terrortylor/nvim-comment",
		cmd = { "CommentToggle" },
		config = function()
			require("nvim_comment").setup({ comment_empty = false })
		end,
	},

	-- colorscheme based on wallpaper
	{
		"atalazer/wally.nvim",
		lazy = false,
		priority = 1000,
		build = "./setup.sh",
		init = function()
			require("wally").colorscheme()
			require("plugins.configs.custom_colors")
		end,
		config = function()
			vim.g.wally_wal_dir = "~/.cache/wal"
			vim.g.wally_italic_comments = true
			vim.g.wally_italic_variables = false
			vim.g.wally_italic_keywords = true
			vim.g.wally_italic_functions = false
			vim.g.wally_sidebars = { "qf", "vista_kind", "terminal", "Nvimtree", "Trouble", "packer" }
		end,
	},

	-- colorscheme
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					notify = false,
					mini = false,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
		end,
	},

	-- open large files fast
	{
		"vim-scripts/LargeFile",
		init = function()
			local filepath = vim.fn.expand("%")
			local filesize = vim.fn.getfsize(filepath) / (1024 * 1024)
			local max_filesize = 20 -- megabytes

			-- plugin minimum file size to run
			vim.g.LargeFile = max_filesize

			if filesize > max_filesize then
				require("lazy").load({ plugins = { "LargeFile" } })
			end
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

	-- easy motion
	{
		"phaazon/hop.nvim",
		branch = "v2",
		cmd = "HopChar1",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},

	-- add, replace and remove surround characters
	{
		"ur4ltz/surround.nvim",
		event = "InsertEnter",
		opts = { mappings_style = "sandwich" },
	},

	-- discord rich presence
	{
		"andweeb/presence.nvim",
		cond = function()
			local is_discord_running = vim.fn.systemlist("pgrep -x discord")
			return is_discord_running[1]
		end,
		init = function()
			vim.defer_fn(function()
				require("lazy").load({ plugins = { "presence.nvim" } })
			end, 0)
		end,
	},

	-- show colors code on the document
	{
		"norcalli/nvim-colorizer.lua",
		init = function()
			vim.defer_fn(function()
				require("lazy").load({ plugins = { "nvim-colorizer.lua" } })
			end, 0)
		end,
		config = function()
			require("colorizer").setup()
			require("colorizer").attach_to_buffer()
		end,
	},

	-- qml syntax highlighting
	{
		"peterhoeg/vim-qml",
		ft = "qml",
	},

	-- lsp hint as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.lsp_signature")
		end,
	},

	-- auto close/rename tag
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		ft = {
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"tsx",
			"jsx",
			"xml",
			"php",
			"markdown",
		},
	},

	-- change commentstring according to the lang
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "InsertEnter",
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

	-- highligh other uses of the word under the cursor
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = { "telescope", "NvimTree" },
				modes_denylist = { "i", "v" },
				large_file_cutoff = 3000,
				min_count_to_highlight = 2,
			})
		end,
		init = function()
			vim.defer_fn(function()
				require("lazy").load({ plugins = { "vim-illuminate" } })
			end, 0)
		end,
	},
}

require("lazy").setup(plugins, opts)
