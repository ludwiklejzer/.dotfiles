local M = {}

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

-- auto commands
M.augroup = function(name, clear)
	vim.api.nvim_create_augroup(name, { clear = clear })
end

M.autocmd = function(event, group, pattern, cmd)
	vim.api.nvim_create_autocmd(event, {
		group = group,
		pattern = pattern,
		command = cmd,
	})
end

M.setSpellLang = function(lang)
	local clients = vim.lsp.buf_get_clients()

	for i, client in ipairs(clients) do
		if client.name == "ltex" then
			clients[i].config.settings.ltex.language = lang
			print("ltex: Language changed to " .. lang)
			break
		end
	end
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

_G.OpenSsl = {
	open = function()
		local password = vim.fn.inputsecret("Password: ")
		vim.fn.execute(
			":'[,']!openssl enc -a -d -aes-256-cbc -md sha512 -pbkdf2 -salt -iter 100000 -pass pass:'"
				.. password
				.. "'"
		)
	end,

	save = function()
		local password = vim.fn.inputsecret("Password: ")
		vim.fn.execute(
			":'[,']!openssl enc -a -aes-256-cbc -md sha512 -pbkdf2 -salt -iter 100000 -pass pass:'" .. password .. "'"
		)
	end,
}

return M
