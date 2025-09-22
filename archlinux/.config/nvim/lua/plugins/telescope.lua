-- fuzzy finder
local function config()
	local telescope = require("telescope")
	local autocmd = vim.api.nvim_create_autocmd
	local actions = require("telescope.actions")

	-- Disable cursorline in Telescope buffers
	autocmd({ "FileType" }, {
		group = nil,
		pattern = "TelescopePrompt",
		command = "setlocal nocursorline",
	})

	local ivy_layout = {
		theme = "ivy",
		layout_config = {
			height = 15,
		},
		border = {
			prompt = { 0, 0, 0, 0 },
			results = { 1, 0, 0, 0 },
			preview = { 1, 1, 1, 1 },
		},
		borderchars = {
			{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
	}

	telescope.setup({
		pickers = {
			live_grep = ivy_layout,
			lsp_workspace_symbols = ivy_layout,
			lsp_dynamic_workspace_symbols = ivy_layout,
			lsp_document_symbols = ivy_layout,
			keymaps = ivy_layout,
		},
		defaults = require("telescope.themes").get_cursor({
			borderchars = {
				{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
				preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
			layout_config = {
				height = 13,
				width = function()
					local win_width = vim.api.nvim_win_get_width(0)
					if win_width > 70 then
						return 60
					else
						return win_width - 2
					end
				end,
				preview_cutoff = 130,
				prompt_position = "bottom",
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			file_ignore_patterns = { "node_modules/", ".git/", "__pycache__", "dist/", "build/" },
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			preview = false,
			preview_title = "",
			results_title = false,
			prompt_prefix = "-> ",
			selection_caret = "",
			entry_prefix = "",
			initial_mode = "insert",
			path_display = { "smart" },
			sorting_strategy = "ascending",
		}),
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
			},
		},
	})

	require("telescope").load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	config = config,
}
