return {
	name = "Terraform",
	treesitter = { "hcl", "terraform" },
	lsp = {
		terraformls = {},
		tflint = {},
	},
	formatters_by_ft = {
		terraform = { "terraform_fmt" },
		["terraform-vars"] = { "terraform_fmt" },
	},
}
