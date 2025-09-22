-- nvim lua docs, signature and completion
return {
	"folke/lazydev.nvim",
	ft = "lua",
	-----@alias lazydev.Library {path:string, words:string[], mods:string[]}
	---@alias lazydev.Library.spec string|{path:string, words?:string[], mods?:string[]}
	---@class lazydev.Config
	opts = {},
}
