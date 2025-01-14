return function(capabilities, on_attach)
    local log_location = vim.fn.stdpath('data') .. '/terraformls.{{pid}}.log'
    require('lspconfig').terraformls.setup({
        capabilities = capabilities,
        cmd = { "terraform-ls", "serve", "-log-file=" .. log_location },
        on_attach = on_attach
    })
end
