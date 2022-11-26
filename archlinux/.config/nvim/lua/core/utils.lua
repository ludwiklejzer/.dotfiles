local M = {}

local cmd = vim.cmd

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

_G.Compile = function()
	local filetype = vim.bo.filetype
	local input = vim.fn.expand("%:p")
	local output = "/tmp/" .. vim.fn.expand("%:t:r")

	local language_config = {
		c = "gcc -o " .. output .. " " .. input .. " && " .. output,
		cpp = "g++ -o " .. output .. " " .. input .. " && " .. output,
		python = "python " .. input,
		javascript = "node " .. input,
		lua = "luajit " .. input,
	}

	for language, compiler_cmd in pairs(language_config) do
		if filetype == language then
			local open_terminal = ":w | below 10sp term://"
			local final_cmd = open_terminal .. compiler_cmd
			vim.cmd(final_cmd)
		end
	end
end

return M
