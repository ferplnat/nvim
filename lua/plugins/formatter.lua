--- @type LazyPluginSpec
return {
    name = 'formatter',
    [1] = 'mhartington/formatter.nvim',

    config = function()
        local format_on_save_filetypes = {
            'go',
            'cs',
            'lua',
        }

        require('formatter').setup({
            logging = true,
            filetype = {
                ["go"] = {
                    function()
                        if not vim.fn.executable('gofmt') then
                            print('gofmt is not installed! Please install it to use this formatter.')
                            return
                        end

                        return {
                            exe = 'gofmt',
                            stdin = true,
                        }
                    end,
                },

                ["*"] = {
                    function()
                        vim.lsp.buf.format({ async = false })
                    end,
                },
            }
        })

        require('marco.remaps.formatter').apply()

        local auto_command_group = vim.api.nvim_create_augroup("marco-formatter", {})

        vim.api.nvim_create_autocmd("BufWritePost", {
            group = auto_command_group,
            callback = function()
                require('marco.utils').remove_trailing_whitespace()

                if vim.tbl_contains(format_on_save_filetypes, vim.bo.filetype) then
                    vim.cmd([[silent! :noautocmd FormatWrite]])
                    return
                end

                vim.cmd([[silent! :noautocmd write]])
            end
        })
    end,
}
