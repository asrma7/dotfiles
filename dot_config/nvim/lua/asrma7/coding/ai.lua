local specs = {}

for _, module in ipairs({
	"copilot",
	"agentic",
}) do
	vim.list_extend(specs, require("asrma7.coding.ai." .. module))
end

return specs
