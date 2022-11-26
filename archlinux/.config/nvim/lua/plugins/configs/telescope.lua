local telescope = require('telescope')

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
			{ '─', '│', '─', '│', '┌', '┐', '┘', '└' },
			prompt = { "─", "│", " ", "│", '┌', '┐', "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
			preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
		},
		file_ignore_patterns = { "node_modules", ".git" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		preview_title = "",
		results_title = false,
		-- preview = false,
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = " ",
		initial_mode = "insert",
		path_display = { "smart" },
		sorting_strategy = "ascending",
		layout_strategy = 'center',
		layout_config = {
			center = {
				height = 0.5,
				width = 60,
				prompt_position = 'top',
				preview_cutoff = 1,
				mirror = false,
			}
		}
	},
	extensions = {
	},
}

telescope.setup(options)
