local bufferline = require("bufferline")

bufferline.setup({
	options = {
		numbers = "none",
		tab_size = 10,
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = "vertical sbuffer %d",
		indicator = { style = "icon", icon = " " },
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		diagnostics = "nvim_lsp",
		offsets = { { filetype = "NvimTree", text = "", text_align = "center" } },
		show_close_icon = true,
		separator_style = { "", "" },
	},
	highlights = {
		buffer_selected = {
			italic = false,
			bg = "NONE",
		},
		numbers = { bg = "NONE" },
		close_button = { bg = "NONE" },
		close_button_selected = { bg = "NONE" },
		separator = { bg = "NONE" },
		separator_selected = { bg = "NONE" },
		separator_visible = { bg = "NONE" },
		tab_selected = { bg = "NONE" },
		background = { bg = "NONE" },
	},
})
