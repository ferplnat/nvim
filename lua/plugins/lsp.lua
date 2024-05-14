--- @type LazyPluginSpec
return {
    name = 'lsp',
    [1] = 'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Fixes for Omnisharp
        'Hoffs/omnisharp-extended-lsp.nvim',
        -- Dont use Omnisharp's built-in LSP
        'jmederosalvarado/roslyn.nvim',
        'folke/neodev.nvim',
    },

    config = function()
        require('mason').setup()
        local remaps = require('marco.remaps.lsp')

        local ensure_installed = {
            'azure_pipelines_ls',
            'bashls',
            'clangd',
            'dockerls',
            'gopls',
            'lua_ls',
            'marksman',
            'taplo',
            'terraformls',
            'tflint',
        }

        if jit.os == 'Windows' then
            table.insert(ensure_installed, 'powershell_es')
            table.insert(ensure_installed, 'omnisharp@v1.39.8') -- 1.39.10 is broken; 1.39.9 is worse.
        end

        -- neodev needs to be called before lspconfig
        require("neodev").setup({})

        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('cmp_nvim_lsp').default_capabilities())

        local my_onattach = function(_, bufnr)
            remaps.on_attach(bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end

        -- LSP Server Specific Configs
        local handlers = {
            [1] = function(server_name)
                -- Check if there is a handler for this server in my [nvim]/lspconfigs/handlers folder
                local success, handler = pcall(require, 'lspconfigs.handlers.' .. server_name)

                if success and type(handler) == 'function' then
                    handler(lsp_capabilities, my_onattach)
                else
                    if success then
                        vim.api.nvim_notify('Handler is not a function: ' .. server_name,
                            vim.log.levels.ERROR { title = 'LSP Config' })
                    end

                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_capabilities,
                        on_attach = my_onattach,
                    })
                end
            end,
        }

        require('lspconfigs.handlers.custom.fastbuild_vscode')(lsp_capabilities, my_onattach)

        require('mason-lspconfig').setup({
            ensure_installed = ensure_installed,
            handlers = handlers,
        })
    end,
}
