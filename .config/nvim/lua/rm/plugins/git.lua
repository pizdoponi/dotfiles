return {
	{
		"tpope/vim-fugitive",
		version = "*",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>gst", "<Cmd>tab Git<CR>", { desc = "Git status" })
			vim.keymap.set("n", "<leader>gc", "<Cmd>Git commit -v<CR>", { desc = "Git commit" })
			vim.keymap.set("n", "<leader>gca", "<Cmd>Git commit --amend --no-edit<CR>", { desc = "Git commit --amend" })

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitcommit",
				callback = function()
					vim.cmd.wincmd("L")
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				vim.keymap.set(
					{ "n", "x" },
					"<leader>ga",
					":Gitsigns stage_hunk<CR>", -- NOTE: <Cmd> does not work here for some reason.
					{ buffer = bufnr, desc = "Stage/unstage hunk" }
				)
				vim.keymap.set(
					"n",
					"<C-k>",
					"<Cmd>Gitsigns preview_hunk_inline<CR>",
					{ buffer = bufnr, desc = "Preview hunk" }
				)
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { buffer = bufnr, desc = "Next change" })
				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { buffer = bufnr, desc = "Previous change" })
			end,
		},
	},
}
