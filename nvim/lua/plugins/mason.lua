return {
    -- Manage/Install LSP's in our system
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    -- Bridges the gap between Mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- install language servers
                    "lua_ls",
                    "gopls",
                    "ts_ls",
                    "clangd",
                    "sqls",
                    "tailwindcss",
                    "intelephense",
                    "html",
                    "emmet_ls",
                    -- install formattersmason

                    -- formatter
                    -- "stylua"
                },
            })
        end,
    },
    -- Bridges the gap between Mason and none-ls
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "stylua",
                    "prettier",
                    "clang_format",
                },
            })
        end,
    },
}
