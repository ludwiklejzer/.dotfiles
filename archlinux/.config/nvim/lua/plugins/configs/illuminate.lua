require("illuminate").configure({
	filetypes_denylist = { "telescope", "NvimTree" },
	modes_denylist = { "i", "v" },
	large_file_cutoff = 3000,
	min_count_to_highlight = 2,
})
