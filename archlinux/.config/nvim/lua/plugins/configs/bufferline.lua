local bufferline = require('bufferline')

bufferline.setup {
	options = {
		numbers = 'buffer_id',
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = "vertical sbuffer %d", 
		-- indicator_icon = '▎',
		indicator = { style = 'icon', icon = ' ' },
		-- buffer_close_icon = '',
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		diagnostics = "nvim_lsp",
		offsets = {{filetype = "NvimTree", text = "", text_align = "center" }},
		show_close_icon = true,
		separator_style = { '/', '/' },
	},
}
