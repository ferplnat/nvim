require('mason').setup()

ensure_installed = {
    'azure_pipelines_ls',
    'lua_ls',
}

if jit.os == 'Windows' then
    table.insert(ensure_installed, 'powershell_es')
end

require('mason-lspconfig').setup({
  ensure_installed = ensure_installed
})

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local get_servers = require('mason-lspconfig').get_installed_servers

local my_onattach = function(client)
    -- client
end

-- neodev needs to be called before lspconfig
require("neodev").setup({})

for _, server_name in ipairs(get_servers()) do
  lspconfig[server_name].setup({
    capabilities = lsp_capabilities,
    on_attach = my_onattach,
  })
end

-- LSP Server Specific Configs

lspconfig.powershell_es.setup({
    capabilities = lsp_capabilities,
    shell = "powershell.exe", -- Make sure we're using Windows PowerShell 5.1
    filetypes = {
        "ps1",
        "psm1",
    },
    settings = {
        powershell = {
            codeFormatting = {
                openBraceOnSameLine = true,
                newLineAfterCloseBrace = true,
            },
        },
    },
})

lspconfig.azure_pipelines_ls.setup({
    capabilities = lsp_capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                    "**Azure*/**/*.yaml",
                    "**Azure*/**/*.yml",
                    "**AzDO*/**/*.yml",
                    "**AzDO*/**/*.yaml",
                },
            },
        },
    },
})

require('lspconfig').lua_ls.setup {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}

-- Completion

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

local completion_kinds = require('cmp.types').lsp.CompletionItemKind
local kind_index = 1
local filter_source = function(entry)
    return completion_kinds[entry:get_kind()] == completion_kinds[kind_index]
end

local insert_completion_sources = {
    { name = 'nvim_lsp', group_index = 1 },
    { name = 'luasnip', group_index = 1 },
    { name = 'nvim_lua', group_index = 2 },
    { name = 'buffer', group_index = 2 },
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Return>'] = cmp.mapping.confirm({ select = false }),
        ["<C-s>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                fallback()
            -- expand_or_locally_jumpable() is used to avoid errant jumps outside of luasnip regions
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                fallback()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    sources = insert_completion_sources
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {
            { name = 'path' }
        },
        {
            { name = 'cmdline' }
        })
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { buffer = event.buf, desc = "[g]o to [d]efinition" })
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { buffer = event.buf, desc = "Show hover" })
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, { buffer = event.buf, desc = "[v]iew [w]orkspace [s]ymbol" })
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, { buffer = event.buf, desc = "[v]iew [d]iagnostic float" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, { buffer = event.buf, desc = "next [d]iagnostic" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, { buffer = event.buf, desc = "previous [d]iagnostic" })
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, { buffer = event.buf, desc = "[v]iew [c]ode [a]ction" })
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, { buffer = event.buf, desc = "[v]ariable [r]efe[r]ences" })
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, { buffer = event.buf, desc = "[v]ariable [r]e[n]ame" })
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, { buffer = event.buf, desc = "signature [h]elp" })
  end,
})
