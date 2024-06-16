local M = {}

M.get_hl_fg = function(group)
	local fg = vim.api.nvim_get_hl(0, { name = group }).fg
	return fg
end

M.get_hl_bg = function(group)
	local bg = vim.api.nvim_get_hl(0, { name = group }).bg
	return bg
end

-- mapping
M.map = function(mode, keys, command, opt)
	local options = { noremap = true, silent = true }

	if opt then
		options = vim.tbl_extend("force", options, opt)
	end

	if type(keys) == "table" then
		for _, keymap in ipairs(keys) do
			M.map(mode, keymap, command, opt)
		end
		return
	end

	vim.keymap.set(mode, keys, command, opt)
end

-- lazy loading
M.lazy_load = function(plugin)
	vim.schedule(function()
		require("lazy").load({ plugins = plugin })

		if plugin == "nvim-lspconfig" then
			vim.cmd("silent! do FileType")
		end
	end, 0)
end

-- Globals

return M
