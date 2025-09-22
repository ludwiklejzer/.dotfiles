-- git symbols (added, deleted, changed) in the signcolumn
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "GitSignsAdd" })

vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "GitSignsChangeLn" })

vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitSignsDelete" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "GitSignsDeleteLn" })

vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "GitSignsChangeLn" })

local options = {
	signs = {
		add = { text = "+" },
		change = { text = "|" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
}

return {
	"lewis6991/gitsigns.nvim",
	ft = "gitcommit",
	init = function()
		-- load gitsigns only when a git file is opened
		vim.api.nvim_create_autocmd({ "BufRead" }, {
			group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
			callback = function()
				vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
				if vim.v.shell_error == 0 then
					vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
					vim.schedule(function()
						require("lazy").load({ plugins = { "gitsigns.nvim" } })
					end)
				end
			end,
		})
	end,
	opts = options,
}
