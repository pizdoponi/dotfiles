return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	lazy = true,
	config = function()
		require("nvim-treesitter.configs").setup({
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select [L]hs of an assignment" },
						["=r"] = { query = "@assignment.rhs", desc = "Select [R]hs of an assignment" },

						["aa"] = { query = "@parameter.outer", desc = "outer parameter" },
						["ia"] = { query = "@parameter.inner", desc = "inner parameter" },

						["ai"] = { query = "@conditional.outer", desc = "outer conditional" },
						["ii"] = { query = "@conditional.inner", desc = "inner conditional" },

						["ao"] = { query = "@loop.outer", desc = "outer loop" },
						["io"] = { query = "@loop.inner", desc = "inner loop" },

						["an"] = { query = "@call.outer", desc = "outer function call" },
						["in"] = { query = "@call.inner", desc = "inner function call" },

						["am"] = { query = "@function.outer", desc = "outer method" },
						["im"] = { query = "@function.inner", desc = "inner method" },

						["ar"] = { query = "@class.outer", desc = "outer class" },
						["ir"] = { query = "@class.inner", desc = "inner class" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>;a"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>;p"] = "@property.outer", -- swap object property with next
						["<leader>;m"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>,a"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>,p"] = "@property.outer", -- swap object property with prev
						["<leader>,m"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]n"] = { query = "@call.outer", desc = "Next function call start" },
						["]m"] = { query = "@function.outer", desc = "Next function start" },
						["]r"] = { query = "@class.outer", desc = "Next class end" },
						["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						["]o"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_next_end = {
						["]N"] = { query = "@call.outer", desc = "Next function call end" },
						["]M"] = { query = "@function.outer", desc = "Next function end" },
						["]R"] = { query = "@class.outer", desc = "Next class end" },
						["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						["]O"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						["[n"] = { query = "@call.outer", desc = "Prev function call start" },
						["[m"] = { query = "@function.outer", desc = "Prev function start" },
						["[r"] = { query = "@class.outer", desc = "Prev class start" },
						["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						["[o"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						["[N"] = { query = "@call.outer", desc = "Prev function call end" },
						["[M"] = { query = "@function.outer", desc = "Prev function end" },
						["[R"] = { query = "@class.outer", desc = "Prev class end" },
						["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						["[O"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

		local repeat_movement = function(forward, backward)
			local a, b = ts_repeat_move.make_repeatable_move_pair(function()
				vim.cmd("normal! " .. forward)
			end, function()
				vim.cmd("normal! " .. backward)
			end)
			vim.keymap.set({ "n", "x", "o" }, forward, a)
			vim.keymap.set({ "n", "x", "o" }, backward, b)
		end

		repeat_movement("]s", "[s")
		-- repeat_movement("])", "[(")
		-- repeat_movement("]}", "[{")
		-- repeat_movement("]>", "[<")

		-- Register which-key mappings
		require("which-key").add({
			{ "<leader>;", group = "Swap next" },
			{ "<leader>,", group = "Swap prev" },
		})
	end,
}
