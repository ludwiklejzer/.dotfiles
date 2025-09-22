-- completion engine
local function config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local context = require("cmp.config.context")
	local copilot = require("copilot.suggestion")

	local function border(hl_name)
		return {
			{ "┌", hl_name },
			{ "─", hl_name },
			{ "┐", hl_name },
			{ "│", hl_name },
			{ "┘", hl_name },
			{ "─", hl_name },
			{ "└", hl_name },
			{ "│", hl_name },
		}
	end

	local cmp_window = require("cmp.utils.window")

	function cmp_window:has_scrollbar()
		return false
	end

	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		experimental = {
			ghost_text = true,
		},
		enabled = function()
			-- disable completion in comments and prompt buftype
			-- keep command mode completion enabled when cursor is in a comment
			local buftype = vim.bo.buftype

			if buftype == "prompt" then
				return false
			elseif context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
				return false
			else
				return true
			end
		end,
		view = {
			entries = {
				follow_cursor = true,
			},
		},
		window = {
			completion = cmp.config.window.bordered({
				border = border("Comment"),
				winhighlight = "Normal:None,FloatBorder:TelescopeBorder,CursorLine:PmenuSel,Search:None,CmpItemMenu:Comment",
				col_offset = 0,
				side_padding = 1,
				scrollbar = false,
				completeopt = "menu,menuone,noinsert,preview",
			}),
			documentation = cmp.config.window.bordered({
				border = border("Comment"),
				winhighlight = "Normal:None,FloatBorder:TelescopeBorder,CursorLine:PmenuSel,Search:None",
			}),
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		formatting = {
			expandable_indicator = true,
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local icons = {
					Text = "",
					Method = "",
					Function = "󰊕",
					Constructor = "",
					Field = "ﰠ",
					Variable = "󰀫 ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					TypeParameter = "",
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Control = " ",
					Collapsed = " ",
					Key = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Reference = " ",
					String = " ",
					Copilot = "",
					Codeium = "",
					Calc = "󰃬",
					Spell = "󰓆",
				}
				vim_item.menu = ({
					dotenv = "EnvVar",
					buffer = "Buffer",
					nvim_lsp = "LSP",
					luasnip = "LuaSnip",
					path = "   Path",
					spell = "  Spell",
					calc = "   Calc",
					emoji = "  Emoji",
					orgmode = "Orgmode",
					neorg = "Neorg",
					["html-css"] = "[html-css]",
				})[entry.source.name]

				if entry.source.name == "calc" then
					vim_item.kind = "󰃬"
				elseif entry.source.name == "spell" then
					vim_item.kind = "󰓆"
				elseif entry.source.name == "buffer" then
					vim_item.kind = "󰌨"
				elseif entry.source.name == "orgmode" then
					vim_item.kind = ""
				elseif entry.source.name == "html-css" then
					vim_item.kind = ""
				else
					vim_item.kind = icons[vim_item.kind]
				end

				vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 }

				return vim_item
			end,
		},
		mapping = {
			["<A-e>"] = cmp.mapping(function()
				copilot.dismiss()
			end, { "i", "s" }),
			["<M-j>"] = cmp.mapping(function()
				cmp.abort()
				copilot.next()
			end, { "i", "s" }),
			["<M-k>"] = cmp.mapping(function()
				cmp.abort()
				copilot.prev()
			end, { "i", "s" }),
			["<M-w>"] = cmp.mapping(function()
				copilot.accept_word()
			end, { "i", "s" }),
			["<M-l>"] = cmp.mapping(function()
				copilot.accept_line()
			end, { "i", "s" }),

			["<C-p>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				elseif luasnip.jumpable(-1) then
					vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
				else
					cmp.complete()
				end
			end, { "i", "s" }),
			["<C-n>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				elseif luasnip.expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
				else
					cmp.complete()
				end
			end, { "i", "s" }),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<C-y>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			["<CR>"] = cmp.mapping(function(fallback)
				if copilot.is_visible() then
					copilot.accept()
				elseif cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					})
				else
					fallback()
				end
			end, { "i", "s" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if copilot.is_visible() then
					copilot.accept()
				elseif cmp.visible() then
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					})
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		sources = {
			{
				name = "beancount",
				option = { account = vim.fn.expand("~/beancount/main.beancount") },
			},
			{
				name = "luasnip",
				option = { use_show_condition = true },
				-- prevent triggering from inside of strings
				entry_filter = function()
					return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
				end,
			},
			{ name = "neorg" },
			-- { name = "codeium" },
			-- { name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			-- { name = "spell" },
			{ name = "calc" },
			{ name = "buffer" },
			{ name = "emoji" },
			{ name = "dotenv" },
			{ name = "lazydev", group_index = 0 },
			{
				name = "html-css",
				option = {
					enable_on = { "html", "jsx", "tsx" },
					dir_to_exclude = { "node_modules" },
					file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
					style_sheets = {
						-- example of remote styles, only css no js for now
						-- "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
					},
				},
			},
		},
	})

	cmp.setup.cmdline({ ":", "/", "?", "@" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(
			{ { name = "path" } },
			{ { name = "cmdline" } },
			{ { name = "emoji" } },
			{ { name = "buffer" } },
			{ { name = "dotenv", option = { eval_on_confirm = true } } }
		),
	})

	-- buffer-specific configs
	cmp.setup.filetype({ "TelescopePrompt" }, {
		sources = {},
	})

	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
			{ name = "calc" },
			{ name = "path" },
		},
	})

	-- sql
	cmp.setup.filetype({ "sql" }, {
		sources = {
			{ name = "vim-dadbod-completion" },
			{ name = "buffer" },
		},
	})

	cmp.setup.filetype({ "typr" }, {
		sources = {},
	})
end

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	config = config,

	dependencies = {
		-- cmp sources
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-cmdline",
		"SergioRibera/cmp-dotenv",
		"crispgm/cmp-beancount",
		{
			"zbirenbaum/copilot-cmp",
			build = ":Copilot auth",
			config = function()
				require("copilot_cmp").setup()
			end,
		},
	},
}
