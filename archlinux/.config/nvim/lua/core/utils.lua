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

-- Globals

_G.OpenSsl = {
	encrypted_file_path = nil,

	decrypt = function()
		local password = vim.fn.inputsecret("Password: ")
		OpenSsl.encrypted_file_path = vim.fn.expand("%:p")

		os.execute(
			"openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "
				.. vim.fn.expand("%:p")
				.. " -out /tmp/"
				.. vim.fn.expand("%:t")
				.. " -pass pass:'"
				.. password
				.. "'"
		)

		vim.fn.execute(":bd | e /tmp/" .. vim.fn.expand("%:t"))
	end,

	encrypt = function()
		local password = vim.fn.inputsecret("Password: ")
		local output_filename = vim.fn.input("File name: ")

		os.execute(
			"openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in "
				.. vim.fn.expand("%:p")
				.. " -out "
				.. output_filename
				.. ".aes -pass pass:"
				.. password
		)
	end,

	save = function()
		local password = vim.fn.inputsecret("Password: ")

		os.execute(
			"openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -salt -in /tmp/"
				.. vim.fn.expand("%:t")
				.. " -out "
				.. OpenSsl.encrypted_file_path
				.. " -pass pass:"
				.. password
		)
	end,

	exit = function()
		os.execute("rm /tmp/" .. vim.fn.expand("%:t"))
	end,
}

return M
