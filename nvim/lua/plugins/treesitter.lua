return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        {"nvim-treesitter/nvim-treesitter-context"}
    },
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "go",
                "javascript",
                "html",
                "php",
                "php_only",
                "css",
                "blade",
                "sql"
            },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
}
