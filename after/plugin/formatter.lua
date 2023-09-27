local util = require('formatter.util')
local defaults = require('formatter.defaults')

-- NOTE: If using Windows, this requires WSL. All this does is run sed through WSL
-- so you don't have to install extra binaries. I had to use Debian as a default
-- because Ubuntu wasn't working for some reason. YMMV
local function which_sed(pattern, replacement, flags)
    if jit.os == 'Windows' then
        return {
            exe = "wsl -e sed",
            args = {
                util.quote_cmd_arg(util.wrap_sed_replace(pattern, replacement, flags)),
            },
            stdin = true,
        }
    else
        return defaults.sed
    end
end

local remove_trailing_whitespace = util.withl(which_sed, "[ \t]*$")

require('formatter').setup({
    logging = true,
    filetype = {
        ["*"] = {
            remove_trailing_whitespace,
            function()
                vim.lsp.buf.format({ async = false })
            end
        }
    }
})
