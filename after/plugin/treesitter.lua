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
ensure_installed = ensure_installed,
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
      enable = true,
      disable = {"python"}
  },
}
