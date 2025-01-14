--- @type LazyPluginSpec
return {
    name = 'lsp',
    [1] = 'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'seblj/roslyn.nvim',
        'folke/neodev.nvim',
        'blink.cmp',
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
            'html',
            'lua_ls',
            'marksman',
            'powershell_es',
            'taplo',
            'terraformls',
            'tflint',
        }

        -- neodev needs to be called before lspconfig
        require("neodev").setup()

        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('blink.cmp').get_lsp_capabilities())

        local my_onattach = function(_, bufnr)
            remaps.on_attach(bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end

        require("roslyn").setup({
            ---@diagnostic disable-next-line: missing-fields
            config = {
                on_attach = my_onattach,
            }
        })

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
