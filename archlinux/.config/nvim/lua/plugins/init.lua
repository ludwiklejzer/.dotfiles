-- lazy.nvim bootstrap
local opts = require("plugins.configs.lazy_nvim")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {

	-- lua library
	{ "nvim-lua/plenary.nvim" },

	-- manage LSP servers, DAP servers, linters, and formatters
	{
		"williamboman/mason.nvim",
		lazy = false,
		cmd = { "Mason", "MasonInstall", "MasonLog", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			require("plugins.configs.mason")
		end,
	},

	-- integration between lspconfig and mason
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "mason.nvim" },
		opts = function()
			require("plugins.configs.mason-lspconfig")
		end,
	},

	-- inject LSP diagnostics, code actions, and more
	{
		"nvimtools/none-ls.nvim",
		event = "InsertEnter",
		keys = { "K", " ca", "gi" },
		config = function()
			require("plugins.configs.null-ls")
		end,
	},

	-- integration between mason and null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		build = ":NullLsInstall",
		cmd = "NullLsInstall",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = { automatic_installation = true },
	},

	-- nvim lua docs, signature and completion
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		ft = { "lua" },
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
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
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.nvim-treesitter")
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		-- lazy = false,
		cmd = { "DapToggleBreakpoint", "DapContinue" },
		config = function()
			require("plugins.configs.nvim-dap")
		end,
		dependencies = {
			"rcarriga/nvim-dap-ui", -- Debugger UI
			"nvim-neotest/nvim-nio", -- Async IO library
			"jay-babu/mason-nvim-dap.nvim",
			{
				"LiadOz/nvim-dap-repl-highlights",
				config = function()
					require("nvim-dap-repl-highlights").setup()
				end,
			},
		},
	},

	-- completion engine
	{
		"hrsh7th/nvim-cmp",
		event = { "ModeChanged" },
		dependencies = {
			-- cmp sources
			"saadparwaiz1/cmp_luasnip", -- luasnip completion
			"hrsh7th/cmp-nvim-lsp", -- neovim builtin LSP client
			"hrsh7th/cmp-buffer", -- buffer words
			"hrsh7th/cmp-path", -- complete paths
			"f3fora/cmp-spell", -- spell checking
			"hrsh7th/cmp-calc", -- math calculation
			"hrsh7th/cmp-emoji",
			"rcarriga/cmp-dap",
			"SergioRibera/cmp-dotenv",
			"hrsh7th/cmp-cmdline",
			{
				"zbirenbaum/copilot-cmp",
				build = ":Copilot auth",
				config = function()
					require("copilot_cmp").setup()
				end,
			},

			-- ai completion
			-- {
			-- 	"Exafunction/codeium.nvim",
			-- 	build = ":Codeium Auth",
			-- 	opts = {
			-- 		enable_chat = true,
			-- 		language_server = "/home/ludwiklejzer/Downloads/language_server_linux_x64",
			-- 	},
			-- },
		},

		config = function()
			require("plugins.configs.cmp")
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = false,
				},
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
				},
				filetypes = {
					markdown = true,
				},
			})
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

	-- colorscheme
	{
		"svitax/fennec-gruvbox.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			vim.cmd([[colorscheme fennec-gruvbox]])

			-- set transparent hi groups
			vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
				group = nil,
				pattern = "*.norg",
				callback = function()
					vim.api.nvim_set_hl(0, "Folded", { bg = nil, fg = "#585b5c" })
				end,
			})

			local transparent_groups = {
				"StatusLine",
				"Normal",
				"NormalFloat",
				"NormalNC",
				"NormalNC",
				"SignColumn",
				"Pmenu",
				"MsgSeparator",
				"LineNrAbove",
				"LineNrBelow",
				"NvimTreeNormal",
			}

			for _, group in ipairs(transparent_groups) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
			-- Custom hi groups
			vim.api.nvim_set_hl(0, "@neorg.markup.verbatim", { bg = "#333333" })
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
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
		"numToStr/Comment.nvim",
		keys = { { "gc", mode = "v" }, "gcc", "gbc" },
		config = function()
			require("Comment").setup({
				toggler = { line = "gcc", block = "gbc" },
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- change commentstring according to the lang
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		keys = { { "gc", mode = "v" }, "gcc", "gbc" },
	},

	-- add support to editorconfig
	{
		"gpanders/editorconfig.nvim",
		event = "VeryLazy",
	},

	-- handle csv files
	{
		"cameron-wags/rainbow_csv.nvim",
		ft = { "csv", "tsv" },
		opts = {},
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

	-- git commands
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
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

	-- luarocks support
	{
		"vhyrro/luarocks.nvim",
		ft = { "norg" },
		priority = 1000,
		config = true,
		opts = {
			rocks = { "magick" },
		},
	},

	-- personal wiki
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		ft = { "norg" },
		cmd = { "Neorg" },
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("plugins.configs.neorg")
		end,
	},

	-- add image support to neovim
	{
		"3rd/image.nvim",
		ft = { "markdown", "norg" },
		dependencies = { "luarocks.nvim" },
		config = function()
			require("plugins.configs.image")
		end,
	},

	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" },
	},

	-- personal wiki using vimwiki
	{
		"vimwiki/vimwiki",
		cmd = { "VimwikiIndex", "VimwikiDiaryIndex" },
		config = function()
			local patterns = {
				{
					"GoalCompleted",
					[[^\s*- \[X\]\s\+\(\d*%\?\|\d|\d\)\s*\(\d\{4\}-\d\{2\}-\d\{2\}\)\=\s\+\zs.*]],
				},
				{
					"GoalLowPercentage",
					[[^\s*- \[[X\| ]\]\s\+\zs\s*\s[0-4]\{0,1\}[0-9]\{0,1\}%\ze ]],
				},
				{
					"GoalMediumPercentage",
					[[^\s*- \[[X\| ]\]\s\+\zs\s[5-9][0-9]%\ze ]],
				},
				{
					"GoalCompletedPercentage",
					[[^\s*- \[[X\| ]\]\s\+\zs100%\ze ]],
				},
			}
			vim.api.nvim_set_hl(0, "GoalCompleted", { fg = "gray", strikethrough = true, italic = true })
			vim.api.nvim_set_hl(0, "GoalLowPercentage", { fg = "#555555" })
			vim.api.nvim_set_hl(0, "GoalMediumPercentage", { fg = "#999999" })
			vim.api.nvim_set_hl(0, "GoalCompletedPercentage", { fg = "#FFFFFF" })

			for _, value in pairs(patterns) do
				vim.fn.matchadd(value[1], value[2])
			end
		end,
		init = function()
			require("plugins.configs.vimwiki")
		end,
	},

	-- pretty diagnostics, references, telescope results, quickfix and loclist
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- SchemaStore catalog for json and yaml
	{
		"b0o/schemastore.nvim",
		ft = { "json", "yaml" },
	},

	-- discord rich presence
	-- {
	-- 	"andweeb/presence.nvim",
	-- 	event = "VeryLazy",
	-- },
}

require("lazy").setup(plugins, opts)
