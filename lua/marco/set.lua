vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 10

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'
vim.opt.guicursor = '' -- Don't cursor for insert mode
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.pumheight = 10

vim.g.mapleader = ' '
vim.o.mouse = '' -- Disable mouse support

vim.opt.termguicolors = true

vim.o.cmdheight = 3

-- Relative line numbers with a different color for specified intervals
local interval = 5
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
        shell = 'powershell',
        shellcmdflag =
        '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
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
local auto_command_group = vim.api.nvim_create_augroup('marco-autocmd', {})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = auto_command_group,
    callback = function()
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
