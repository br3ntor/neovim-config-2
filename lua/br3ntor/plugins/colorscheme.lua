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
			vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0A0B0F" })
			vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#0A0B0F" })
		end,
	},
	-- {
	-- 	"sainnhe/gruvbox-material",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.gruvbox_material_background = "hard"
	-- 		vim.g.gruvbox_material_foreground = "mix"
	-- 		vim.g.gruvbox_material_enable_italic = true
	-- 		vim.g.gruvbox_material_better_performance = 1
	-- 		vim.g.gruvbox_material_colors_override = {
	-- 			bg0 = { "#0A0B0F", "234" }, -- Custom dark blue-gray background
	-- 			-- bg1 = { "#1A1B1F", "235" }, -- Slightly lighter variant
	-- 			-- bg2 = { "#2A2B2F", "237" }, -- Even lighter variant
	-- 		}
	-- 		vim.cmd.colorscheme("gruvbox-material")
	-- 	end,
	-- },
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
