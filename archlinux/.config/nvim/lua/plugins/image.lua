-- add image support to neovim
local options = {
	backend = "kitty",
	kitty_method = "normal",
	processor = "magick_rock",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		neorg = {
			enabled = true,
			clear_in_insert_mode = true,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			filetypes = { "norg" },
		},
	},
	max_height_window_percentage = 35,
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
}

return {
	"3rd/image.nvim",
	ft = { "markdown", "norg" },
	dependencies = { "luarocks.nvim" },
	opts = options,
}
