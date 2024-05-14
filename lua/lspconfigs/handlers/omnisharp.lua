return function(capabilities, on_attach)
    --require("roslyn").setup({
    --    dotnet_cmd = "dotnet",                -- this is the default
    --    roslyn_version = "4.11.0-1.24209.10", -- this is the default
    --    on_attach = on_attach,
    --    capabilities = capabilities,
    --})

    vim.filetype.add({
        extension = {
            ['razor'] = 'razor',
        }
    })

    vim.fn.setenv("OMNISHARPHOME", vim.fn.stdpath('config') .. '/lsp-config-files/omnisharp/')

    local omnisharp_cmd
    if jit.os == 'Windows' then
        omnisharp_cmd = { vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/omnisharp.exe' }
    end

    require('lspconfig').omnisharp.setup({
        cmd = omnisharp_cmd,
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'cs', 'vb', },
        handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        root_dir = require('lspconfig').util.root_pattern('*.sln', '*.csproj', 'omnisharp.json',
            'function.json'),

        -- Disable all so that omnisharp.json is used
        enable_editorconfig_support = false,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = false,
        sdk_include_prereleases = false,
        analyze_open_documents_only = false,
    })
end
