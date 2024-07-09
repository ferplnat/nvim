local M = {}

M.apply = function()
    --- @diagnostic disable-next-line: missing-fields
    require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark",   -- style for floating windows
        },
        sidebars = {
            "help",
            "qf",
            "undotree",
        },                                -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        on_highlights = function(hl, c)
            local accent = "#2d3149"

            hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
            }

            hl.TelescopeBorder = {
                bg = accent,
                fg = accent,
            }

            hl.TelescopePromptNormal = {
                bg = accent,
            }

            hl.TelescopePromptBorder = {
                bg = accent,
                fg = accent,
            }

            hl.TelescopePromptTitle = {
                bg = c.bg_search,
                fg = c.fg_dark,
            }

            hl.TelescopePreviewTitle = {
                bg = c.bg_search,
                fg = c.fg_dark,
            }

            hl.TelescopeResultsTitle = {
                bg = c.bg_search,
                fg = c.fg_dark,
            }

            hl.TelescopeTitle = {
                bg = c.bg_search,
                fg = c.fg_dark,
            }

            hl.Boolean = {
                fg = c.orange,
                italic = true,
            }

            hl['@variable'] = {
                bold = true,
            }

            hl['@lsp.type.variable'] = {
                link = "@variable",
            }

            hl['@parameter'] = {
                fg = c.yellow,
                italic = true,
            }

            hl['@variable.parameter'] = {
                link = "@parameter",
            }

            -- TODO FIXME NOTE
            hl.Todo = {
                fg = c.yellow,
            }

            hl['@comment.todo'] = {
                link = "Todo",
            }

            hl['@text.danger.comment'] = {
                fg = c.error,
            }

            hl.StatusLineMode = {
                fg = '#fc9867',
                bg = hl.StatusLine.bg,
            }

            -- ToggleTerm
            hl.ToggleTermNormal = { bg = c.bg_dark }
            hl.ToggleTermNormalFloat = { link = "ToggleTermNormal" }
            hl.ToggleTermStatusLine = { link = "StatusLine" }
        end,
    })
    vim.cmd.colorscheme('tokyonight')
end

return M
