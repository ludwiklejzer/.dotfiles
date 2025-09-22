-- show colors code on the document
return {
	"norcalli/nvim-colorizer.lua",
	event = "InsertEnter",
	config = function()
		require("colorizer").setup()
	end,
}
