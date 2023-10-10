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

if jit.os == 'Windows' then
    local powershell_options = {
      shell = "powershell",
      shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
      shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
      shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
      shellquote = "",
      shellxquote = "",
    }

    for option, value in pairs(powershell_options) do
      vim.opt[option] = value
    end
end
