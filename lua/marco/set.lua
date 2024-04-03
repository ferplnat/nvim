-- Indentation options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.scrolloff = 10

-- Search options
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 200

-- Cursor options
vim.opt.colorcolumn = '80'
vim.opt.guicursor = '' -- Don't cursor for insert mode
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.timeoutlen = 250 -- Time to wait for a mapped sequence to complete (in milliseconds)

vim.opt.pumheight = 15   -- Maximum number of items in the popup menu

vim.g.mapleader = ' '
vim.o.mouse = '' -- Disable mouse support

vim.opt.termguicolors = true

vim.o.cmdheight = 3

-- Statuscolumn options
vim.opt.number = true
vim.opt.relativenumber = true

-- Relative line numbers with a different color for specified intervals
local interval = 10
vim.api.nvim_set_hl(0, 'LineNrAlt', { fg = '#fc9867' })
vim.o.stc = '%#LineNrAlt#%{&rnu&&(v:relnum==0)?"".v:lnum:""}%=' ..
    '%#LineNr#%{&rnu&&(v:relnum%' .. interval .. '&&v:relnum!=0)?"".v:relnum:""}' ..
    '%#LineNrAlt#%{&rnu&&!(v:relnum%' .. interval .. '||v:relnum==0)?"".v:relnum:""} '

local utils = require('marco.utils')

local cursor_center_exclude_filetypes = {
    'lazy',
    'netrw',
    'oil',
    'telescope',
    'TelescopePrompt',
    'toggleterm',
}

if jit.os == 'Windows' then
    local powershell_options = {
        shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell',
        shellcmdflag =
        '-NoLogo -NoProfile -ExecutionPolicy Bypass -Command "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8";',
        shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait',
        shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode',
        shellquote = '',
        shellxquote = '',
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

-- Keep cursor centered at all times
vim.g.centercursor = true

vim.keymap.set('n', '<leader>cc', function() vim.g.centercursor = not vim.g.centercursor end,
    { desc = 'Toggle center cursor' })

local auto_command_group = vim.api.nvim_create_augroup('marco-autocmd', {})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = auto_command_group,
    callback = function()
        if not vim.g.centercursor then
            return
        end

        if vim.list_contains(cursor_center_exclude_filetypes, vim.bo.filetype) then
            return
        end

        local win_info = vim.api.nvim_win_get_config(0)
        if win_info.relative ~= '' or win_info.external then
            return
        end

        utils.execute_keep_cursor(function()
            vim.cmd([[silent! normal! zz]])
        end)
    end,
})

-- Set gitcommit filetype preferences
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = auto_command_group,
    pattern = 'gitcommit',
    callback = function(ev)
        vim.bo[ev.buf].textwidth = 72
    end,
})

vim.filetype.add({
    extension = {
        ['azcli'] = 'azcli',
    }
})

local delete_hidden_buffers = function(opts)
    local buffers = vim.fn.getbufinfo()
    if buffers == nil then
        return
    end

    for _, buffer in pairs(buffers) do
        if buffer.hidden == 1 then
            vim.api.nvim_buf_delete(buffer.bufnr, { force = opts.bang or false })
        end
    end
end

vim.api.nvim_create_user_command('BCleanup', delete_hidden_buffers, { desc = 'Delete all hidden buffers', bang = true })
