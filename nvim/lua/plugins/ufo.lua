return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    config = function()
        vim.o.foldcolumn = "0" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        vim.o.foldexpr = "0"

        -- vim.o.statuscolumn = '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

        -- Add [,] to line
        vim.o.statuscolumn = "%= "
            .. "%s" -- sign column FIXME: figure out how to put on the other side without having to do a lot of shifting
            .. "%{%" -- evaluate this, and then evaluate what it returns
            .. "&number ?"
            .. "(v:relnum ?"
            ..
            'printf("%"..len(line("$")).."s", v:relnum)' -- when showing relative numbers, make sure to pad so things don't shift as you move the cursor
            .. ":"
            .. "v:lnum"
            .. ")"
            .. ":"
            .. '""'
            .. " " -- space between lines and fold
            .. "%}"
            .. "%= "
            .. "%#FoldColumn#" -- highlight group for fold
            .. "%{" -- expression for showing fold expand/colapse
            .. "foldlevel(v:lnum) > foldlevel(v:lnum - 1)" -- any folds?
            .. "? (foldclosed(v:lnum) == -1" -- currently open?
            .. '? ""' -- point down
            .. ':  ""' -- point to right
            .. ")"
            .. ': " "' -- blank for no fold, or inside fold
            .. "}"
            .. "%= " -- spacing between end of column and start of text

        vim.opt.fillchars = {
            foldopen = "", -- ▼ or your preferred open symbol
            foldclose = "", -- ▶ or your preferred close symbol
            fold = " ", -- No filler dots or dashes
            foldsep = " ", -- No separator between folds
            eob = " ",
        }

        -- nvim lsp as LSP client
        -- Tell the server the capability of foldingRange,
        -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        require("ufo").setup({
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                for _, chunk in ipairs(virtText) do
                    if not chunk[1]:match("%d+ lines") then
                        table.insert(newVirtText, chunk)
                    end
                end
                table.insert(newVirtText, { " ", "Folded" })
                return newVirtText
            end,
        })

        vim.keymap.set("n", "zO", require("ufo").openAllFolds, { desc = "Open all Folds" })
        vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "Close all Folds" })
    end,
}
