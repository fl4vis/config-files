return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		spec = {
			{ "<leader>f", group = "Telescope" },
			{ "<leader>l", group = "LSP", icon = "" },
			{ "<leader>a", group = "Harpoon", icon  = "" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				local wk = require("which-key")
				wk.show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
