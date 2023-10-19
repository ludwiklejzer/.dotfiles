local cmp = require("cmp")
local luasnip = require("luasnip")
local context = require("cmp.config.context")

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
	experimental = {
		ghost_text = true,
	},
	enabled = function()
		-- disable completion in comments and prompt buftype
		-- keep command mode completion enabled when cursor is in a comment
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")

		if vim.api.nvim_get_mode().mode == "c" then
			return true
		elseif buftype == "prompt" then
			return false
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	window = {
		completion = {
			border = border("CmpBorder"),
		},
		documentation = {
			border = border("CmpDocBorder"),
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(_, vim_item)
			local icons = {
				Text = "",
				Method = "",
				Function = "󰊕",
				Constructor = "",
				Field = "ﰠ",
				Variable = "󰫧",
				Class = "ﴯ",
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
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "פּ",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				path = "[Path]",
				spell = "[Spell]",
				calc = "[Calc]",
				emoji = "[Emoji]",
				npm = "[NPM]",
			})[_.source.name]

			if _.source.name == "calc" then
				vim_item.kind = "󰃬 Calc"
			elseif _.source.name == "emoji" then
				vim_item.kind = "󰞅 Emoji"
			elseif _.source.name == "spell" then
				vim_item.kind = "󰓆 Spell"
			elseif _.source.name == "buffer" then
				vim_item.kind = "󰌨 Buffer"
			elseif _.source.name == "codeium" then
				vim_item.kind = " Codeium"
			else
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			end

			vim_item.dup = { buffer = 1, path = 1, nvim_lsp = 0 }
			return vim_item
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping(function(fallback)
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
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				cmp.complete()
			end
		end, { "i", "s" }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		["<Tab>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	sources = {
		{
			name = "luasnip",
			option = { use_show_condition = true },
			-- prevent triggering from inside of strings
			entry_filter = function()
				return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
			end,
		},
		{ name = "codeium" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "spell" },
		{ name = "calc" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
		{ name = "emoji" },
	},
})

-- buffer-specific configs
cmp.setup.filetype({ "TelescopePrompt", "aes" }, {
	sources = {},
})
