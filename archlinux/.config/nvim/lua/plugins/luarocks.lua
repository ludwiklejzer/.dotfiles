-- luarocks support
return {
	"vhyrro/luarocks.nvim",
	ft = { "norg" },
	priority = 1000,
	config = true,
	opts = {
		rocks = { "magick" },
	},
}
