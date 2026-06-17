local specs = {}

for _, module in ipairs({
	"treesitter",
	"comments",
	"editing",
	"colorizer",
	"completion",
	"formatting",
	"lsp",
	"diagnostics",
	"debug",
	"ai",
}) do
	vim.list_extend(specs, require("asrma7.coding." .. module))
end

return specs
