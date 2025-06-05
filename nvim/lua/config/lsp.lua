-- help [vim.lsp.buf, vim.diagnostic, lsp-config, lspconfig-all]

vim.lsp.config("luals", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT", -- Neovim uses LuaJIT
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" }, -- Let it know 'vim' is a global
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
})

vim.lsp.config("intelephense", {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
})

vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

vim.lsp.config("html", {
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "templ", "blade" },
    root_markers = { "package.json", ".git" },
    settings = {},
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { "html", "css", "javascript" },
    },
})

vim.lsp.config("emmet", {
    cmd = { "emmet-ls", "--stdio" },
    filetypes = {
        "blade",
        "astro",
        "css",
        "eruby",
        "html",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "typescriptreact",
        "vue",
        "htmlangular",
    },
    root_markers = { ".git" },
})

vim.lsp.config("tailwindcss", {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "blade", "html", "php" },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                blade = "html",
            },
        },
    },
    root_markers = { "tailwind.config.js", "package.json", ".git" },
})

vim.lsp.config("sqls", {
    cmd = { "sqls" },
    filetypes = { "sql", "mysql" },
})

vim.lsp.config("clangd", {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        ".git",
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { "utf-8", "utf-16" },
    },
})

vim.lsp.enable({
    "luals",
    "intelephense",
    "ts_ls",
    "gopls",
    "tailwindcss",
    "html",
    "emmet",
    "clangd",
    "sqls",
})

-- Keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
        vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })

        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show Diagnostic" })

        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Builint LSP formmatter" })
    end,
})
