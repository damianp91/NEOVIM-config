-- NOTE: Show errors, warnongs, TODO's and list
return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	keys = {
		{
		  "<leader>Tw",
		  "<cmd>Trouble diagnostics toggle<CR>",
		  desc = "Open trouble workspace diagnostics"
		},
		{
			"<leader>Td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Open trouble document diagnostics",
		},
		{
		  "<leader>Tq",
		  "<cmd>Trouble quickfix toggle<CR>",
		  desc = "Open trouble quickfix list"
		},
		{
		  "<leader>Tl",
		  "<cmd>Trouble loclist toggle<CR>",
		  desc = "Open trouble location list"
		},
		{
		  "<leader>Tt",
		  "<cmd>Trouble todo toggle<CR>",
		  desc = "Open todos in trouble"
		},
	},
}
