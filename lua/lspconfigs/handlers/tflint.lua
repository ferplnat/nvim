return function(capabilities, on_attach)
    local lspconfig = require('lspconfig')
    local manager = require('lspconfig.manager')

    ---@diagnostic disable-next-line: invisible
    manager._start_new_client = lspconfig.util.add_hook_before(manager._start_new_client,
        function(_, _, new_config, root_dir, _)
            if new_config.name ~= 'tflint' then
                return
            end

            local result = vim.system({ new_config.cmd[1], '--init' }, { cwd = root_dir, text = true }):wait()

            if result.code == 0 and result.stdout then
                vim.api.nvim_notify(result.stdout, vim.log.levels.INFO, {
                    title = 'LSP Config',
                })
                return
            elseif result.code ~= 0 then
                vim.api.nvim_notify('Failed to start tflint language server', vim.log.levels.ERROR, {
                    title = 'LSP Config',
                })
            end
        end)

    lspconfig.tflint.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { 'tflint', '--langserver', '--format', 'json' },
        filetypes = { 'terraform' },
        root_pattern = {
            '.terraform',
            '.git',
            '.tflint.hcl',
        },
    })
end
