-- comment code blocks
return {
	"numToStr/Comment.nvim",
	keys = { { "gc", mode = "v" }, "gcc", "gbc" },
	opts = {
		toggler = { line = "gcc", block = "gbc" },
	},
}
