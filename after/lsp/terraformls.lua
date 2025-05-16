local log_location = vim.fn.stdpath('data') .. '/terraformls.{{pid}}.log'

--- @type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve", "-log-file=" .. log_location },
}
