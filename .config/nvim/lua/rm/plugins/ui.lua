return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			sections = {
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				-- lualine_z = {"searchcount, selectioncount"},
				lualine_z = {},
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {},
	},
}
