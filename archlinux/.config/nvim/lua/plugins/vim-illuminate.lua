-- highligh other uses of the word under the cursor
return {
	"RRethy/vim-illuminate",
	event = "InsertEnter",
	config = function()
		require("illuminate").configure({
			filetypes_denylist = { "telescope", "NvimTree" },
			modes_denylist = { "i", "v" },
			large_file_cutoff = 3000,
			min_count_to_highlight = 2,
		})
	end,
}
