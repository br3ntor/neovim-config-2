return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				styles = { comments = { italic = false }, keywords = { italic = false } },
				on_colors = function(colors)
					colors.bg = "#0A0B0F"
				end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			transparent = true,
	-- 			colors = {
	-- 				theme = {
	-- 					all = {
	-- 						ui = {
	-- 							bg_gutter = "none",
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 			commentStyle = { italic = false },
	-- 			keywordStyle = { italic = false },
	-- 		})
	--
	-- 		vim.cmd([[colorscheme kanagawa]])
	--
	-- 		-- My custom colors
	-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = nil })
	-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
	-- 		vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = "#7A5E00" })
	-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#262626" })
	-- 	end,
	-- },
}
