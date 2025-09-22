-- parser generator (highlight, folding etc)
local function configs()
	require("nvim-treesitter.configs").setup({
		modules = {},
		fold = { enable = true, patterns = {} },
		indent = { enable = true },
		highlight = { enable = true, use_languagetree = true },
		sync_install = false,
		ignore_install = {},
		auto_install = false,
		-- ensure_installed = {
		-- 	"lua",
		-- 	"c",
		-- 	"make",
		-- 	"qmljs",
		-- 	"qmldir",
		-- 	"html",
		-- 	"rasi",
		-- 	"css",
		-- 	"scss",
		-- 	"diff",
		-- 	"sql",
		-- 	"json",
		-- 	"jsonc",
		-- 	"javascript",
		-- 	"jsdoc",
		-- 	"tsx",
		-- 	"typescript",
		-- 	"bash",
		-- 	"python",
		-- 	"markdown_inline",
		-- 	"yaml",
		-- 	"vue",
		-- 	"vim",
		-- 	"ini",
		-- 	"dockerfile",
		-- 	"norg",
		-- 	"git_config",
		-- 	"gitcommit",
		-- 	"git_rebase",
		-- 	"gitignore",
		-- 	"gitattributes",
		-- 	-- "dap_repl",
		-- },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = { query = "@function.outer", desc = "Select outer outer of a function region" },
					["if"] = { query = "@function.inner", desc = "Select outer inner of a function region" },
					["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
					["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
					["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
					["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
					["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
					["ib"] = { query = "@block.inner", desc = "Select inner part of a block region" },
					["ab"] = { query = "@block.outer", desc = "Select outer part of a block region" },
					["ir"] = { query = "@return.inner", desc = "Select inner part of a return region" },
					["ar"] = { query = "@return.outer", desc = "Select outer part of a return region" },
					-- You can also use captures from other query groups like `locals.scm`
					-- ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = true,
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = { query = "@function.outer", desc = "Next function start" },
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]l"] = { query = "@loop.outer", desc = "Next loop start" },
				},
				goto_next_end = {
					["]F"] = { query = "@function.outer", desc = "Next loop end" },
					["]C"] = { query = "@class.outer", desc = "Next class end" },
				},
				goto_previous_start = {
					["[f"] = { query = "@function.outer", desc = "Previous function start" },
					["[c"] = { query = "@class.outer", desc = "Previous class start" },
				},
				goto_previous_end = {
					["[F"] = { query = "@function.outer", desc = "Previous function end" },
					["[C"] = { query = "@class.outer", desc = "Previous class end" },
				},
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = configs,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
