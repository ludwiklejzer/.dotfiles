local g = vim.g

require'nvim-tree'.setup {
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		}
	},
	view = {
		width = 30,
		hide_root_folder = true,
		side = 'left',
	},
	filters = {
		dotfiles = false,
		custom = {
			".git", "node_modules", ".cache"
		}
	},
	git = {
		ignore = true
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		highlight_opened_files = 'none',
		root_folder_modifier = ':~',
		group_empty = true,
		highlight_git = true,
		add_trailing = false,
		indent_markers = {
			enable = false,
		},
		icons = {
			padding = ' ',
			symlink_arrow = '  ',
			glyphs = {

				default = "",
				symlink = "",
				git = {
					deleted = "",
					ignored = "◌",
					renamed = "➜",
					staged = "✓",
					unmerged = "",
					unstaged = "✗",
					untracked = "★",
				},
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			}
		},
	},
}
