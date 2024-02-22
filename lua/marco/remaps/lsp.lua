local M = {}

M.on_attach = function(bufnr)
    local diagnostic_float = {
        width = 50
    }

    local diagnostic_goto_prefs = {
        float = diagnostic_float,
    }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end,
        { buffer = bufnr, desc = "[g]o to [d]efinition" })

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end,
        { buffer = bufnr, desc = "Show hover" })

    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end,
        { buffer = bufnr, desc = "[v]iew [w]orkspace [s]ymbol" })

    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float(diagnostic_float) end,
        { buffer = bufnr, desc = "[v]iew [d]iagnostic float" })

    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next(diagnostic_goto_prefs) end,
        { buffer = bufnr, desc = "next [d]iagnostic" })

    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev(diagnostic_goto_prefs) end,
        { buffer = bufnr, desc = "previous [d]iagnostic" })

    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
        { buffer = bufnr, desc = "[v]iew [c]ode [a]ction" })

    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
        { buffer = bufnr, desc = "[v]ariable [r]efe[r]ences" })

    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end,
        { buffer = bufnr, desc = "[v]ariable [r]e[n]ame" })

    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
        { buffer = bufnr, desc = "signature [h]elp" })
end

return M
