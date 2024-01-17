--- @type LazyPluginSpec
return {
    name = 'formatter',
    [1] = 'mhartington/formatter.nvim',

    config = function()
        local function remove_trailing_whitespace()
            -- Save cursor position
            local curpos = vim.fn.getpos('.')

            vim.cmd([[silent! :keeppatterns %s/[ \t]\+$//ge]])
            -- Restore cursor position
            vim.fn.setpos('.', curpos)
        end

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

        vim.keymap.set("n", "g=", function()
            remove_trailing_whitespace()
            vim.cmd([[silent! :noautocmd FormatWrite]])
        end, { desc = "Format current buffer." })

        local auto_command_group = vim.api.nvim_create_augroup("marco-formatter", {})

        vim.api.nvim_create_autocmd("BufWritePost", {
            group = auto_command_group,
            callback = function()
                remove_trailing_whitespace()

                if vim.tbl_contains(format_on_save_filetypes, vim.bo.filetype) then
                    vim.cmd([[silent! :noautocmd FormatWrite]])
                    return
                end

                vim.cmd([[silent! :noautocmd write]])
            end
        })
    end,
}
