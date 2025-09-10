--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    name = 'lsp',
    [1] = 'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'seblyng/roslyn.nvim',
        'folke/lazydev.nvim',
        'blink.cmp',
    },

    config = function()
        require('mason').setup({
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        })

        require('roslyn').setup({})

        require('lazydev').setup({
            ft = 'lua',
            library = {
                'LazyDev',
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            }
        })

        local remaps = require('marco.remaps.lsp')

        local ensure_installed = {
            'bashls',
            'clangd',
            'dockerls',
            'gopls',
            'html',
            'lua_ls',
            'marksman',
            'taplo',
            'terraformls',
            'tflint',
        }

        local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        lsp_capabilities = vim.tbl_deep_extend('force', lsp_capabilities, require('blink.cmp').get_lsp_capabilities())

        local my_onattach = function(_, bufnr)
            remaps.on_attach(bufnr)
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end

        vim.lsp.config('*', {
            capabilities = lsp_capabilities,
            on_attach = my_onattach,
        })

        require('mason-lspconfig').setup({
            automatic_enable = true,
            ensure_installed = ensure_installed,
        })
    end,
}
