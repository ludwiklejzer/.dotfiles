local pywal_core = require("pywal.core")
local colors = pywal_core.get_colors()

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#111111", fg = "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE", fg = colors.color1 })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = colors.color7 })
