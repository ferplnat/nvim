--- @type LazyPluginSpec
return {
    name = 'linedancing',
    [1] = 'ferplnat/linedancing.nvim',

    dependencies = {
        'vim-fugitive',
        'vim-sleuth',

        'nvim-lua/plenary.nvim',
    },

    config = function()
        local funcs = require('marco.statusline-funcs')
        require('linedancing').setup({
            components = {
                {
                    name = 'filepath',
                    callback = funcs.filepath,
                    highlight = '',
                    event = { 'BufEnter', 'BufLeave', 'BufModifiedSet' },
                    user_event = { 'LazyDone' },
                    position = 'left',
                    eval = true,
                },

                {
                    name = 'fugitive',
                    callback = funcs.fugitive,
                    highlight = '',
                    event = { 'BufEnter', 'BufReadPost', 'BufNewFile' },
                    position = 'left',
                    eval = true,
                },

                {
                    name = 'mode',
                    callback = funcs.mode,
                    highlight = 'StatusLineMode',
                    event = { 'ModeChanged' },
                    position = 'center',
                    eval = false,
                },

                {
                    name = "recording",
                    callback = funcs.recording,
                    highlight = '',
                    event = { 'RecordingEnter', 'RecordingLeave' },
                    position = 'center',
                    eval = false,
                },

                {
                    name = 'buf_info',
                    callback = funcs.buf_info,

                    highlight = '',
                    event = { 'LspAttach', 'LspDetach', 'LspRequest', 'BufEnter', 'BufLeave', 'WinEnter', 'WinLeave' },
                    position = 'right',
                    eval = false,
                },

                {
                    name = "sleuth",
                    callback = funcs.sleuth,
                    highlight = '',
                    event = { 'BufEnter', 'ModeChanged' },
                    position = 'right',
                    eval = true,
                },

                {
                    name = "position",
                    callback = funcs.position,
                    highlight = '',
                    event = { 'CursorMoved', 'CursorMovedI' },
                    position = 'right',
                    eval = true,
                },
            },
        })
    end
}
