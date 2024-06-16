local telescope = require("telescope")

local options = {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		borderchars = {
			{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt = { "", "", "", "", "", "", "", "" },
			results = { "", "", "", "", "", "", "", "" },
			preview = { "", "", "_", "", "", "", "", "" },
		},
		file_ignore_patterns = { "node_modules", ".git", "__pycache__" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		preview_title = "",
		results_title = false,
		-- preview = false,
		prompt_prefix = "-> ",
		selection_caret = "",
		entry_prefix = "",
		initial_mode = "insert",
		path_display = { "smart" },
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				height = 100,
				width = 1000,
				preview_cutoff = 18,
			},
		},
	},
	extensions = {},
}

telescope.setup(options)
