vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.smartindent = false
vim.opt.autoindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false

vim.opt.scrolloff = 10

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
vim.opt.guicursor = "" -- Don't cursor for insert mode
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.pumheight = 10

vim.g.mapleader = " "
vim.o.mouse = nil

vim.opt.termguicolors = true

local cursor_center_exclude_filetypes = {
    'toggleterm',
    'telescope',
    'netrw'
}

if jit.os == 'Windows' then
    local powershell_options = {
        shell = "powershell",
        shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

local auto_command_group = vim.api.nvim_create_augroup('marco-autocmd', {})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = auto_command_group,
    callback = function()
        for _, x in pairs(cursor_center_exclude_filetypes) do
            if vim.bo.filetype == x then
                return
            end
        end

        local curpos = vim.fn.getpos('.')
        vim.cmd([[silent! normal! zz]])
        vim.fn.setpos('.', curpos)
    end,
})

vim.filetype.add({
    extension = {
        ['azcli'] = 'azcli',
    }
})

local delete_hidden_buffers = function()
    local buffers = vim.fn.getbufinfo()

    for _, buffer in pairs(buffers) do
        if buffer.hidden == 1 then
            vim.api.nvim_buf_delete(buffer.bufnr, { force = true })
        end
    end
end

vim.api.nvim_create_user_command('BCleanup', delete_hidden_buffers, { desc = 'Delete all hidden buffers' })
