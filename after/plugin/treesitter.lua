local ensure_installed = {
    'bash',
    'bicep',
    'c',
    'cpp',
    'css',
    'csv',
    'c_sharp',
    'diff',
    'dockerfile',
    'gitcommit',
    'gitignore',
    'git_config',
    'git_rebase',
    'go',
    'gomod',
    'gosum',
    'gowork',
    'html',
    'json',
    'lua',
    'luadoc',
    'markdown',
    'python',
    'regex',
    'sql',
    'ssh_config',
    'terraform',
    'toml',
    'tsv',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}

if jit.os == 'Windows' and vim.fn.isdirectory(vim.fn.expand('~/nvim_parsers/tree-sitter-powershell')) == 1 then
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.PowerShell = {
      install_info = {
        url = "~/nvim_parsers/tree-sitter-powershell",
        branch = "operator001",
        files = {"src/parser.c", "src/scanner.c"}
      },
      filetype = "ps1",
    }

    vim.treesitter.language.register('PowerShell', 'psm1')
    table.insert(ensure_installed, 'PowerShell')
end

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
ensure_installed = ensure_installed,

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
      enable = true,
      disable = {"python"}
  },
}
