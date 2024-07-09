local M = {}

M.apply = function()
    local monokai_pro = require('monokai-pro')
    monokai_pro.setup({
        transparent_background = true,
        terminal_colors = true,
        devicons = false,
        styles = {
            comment = { italic = true },
            keyword = { italic = true },       -- any other keyword
            type = { italic = true },          -- (preferred) int, long, char, etc
            storageclass = { italic = true },  -- static, register, volatile, etc
            structure = { italic = true },     -- struct, union, enum, etc
            parameter = { italic = true },     -- parameter pass in function
            annotation = { italic = true },
            tag_attribute = { italic = true }, -- attribute of tag in reactjs
        },
        filter = "pro",                        -- classic | octagon | pro | machine | ristretto | spectrum

        inc_search = "background",             -- underline | background

        plugins = {
            bufferline = {
                underline_selected = false,
                underline_visible = false,
            },
            indent_blankline = {
                context_highlight = "default", -- default | pro
                context_start_underline = false,
            },
        },
        ---@param c Colorscheme
        override = function(c)
            local hp = require('monokai-pro.color_helper')

            local bg_dark = hp.lighten(c.sideBar.background, 5)
            local fg_dark = hp.lighten(c.sideBar.foreground, 5)

            local bg_accents = hp.lighten(c.sideBar.background, 10)

            local bg_search = bg_dark
            local fg_search = c.base.green

            return {
                Directory = {
                    fg = c.base.green,
                },

                TelescopeNormal = {
                    bg = bg_dark,
                    fg = fg_dark,
                },

                TelescopeBorder = {
                    bg = bg_accents,
                    fg = bg_accents,
                },

                TelescopeTitle = {
                    bg = bg_search,
                    fg = fg_search,
                },

                TelescopeResultsNormal = {
                    bg = bg_dark,
                    fg = fg_dark,
                },

                TelescopeResultsBorder = {
                    bg = bg_accents,
                    fg = bg_accents,
                },

                TelescopeResultsTitle = {
                    link = "TelescopeTitle",
                },

                TelescopePromptNormal = {
                    bg = bg_accents,
                },

                TelescopePromptBorder = {
                    bg = bg_accents,
                    fg = bg_accents,
                },

                TelescopePromptTitle = {
                    link = "TelescopeTitle",
                },

                TelescopePreviewNormal = {
                    bg = bg_dark,
                    fg = fg_dark,
                },

                TelescopePreviewBorder = {
                    bg = bg_accents,
                    fg = bg_accents,
                },

                TelescopePreviewTitle = {
                    link = "TelescopeTitle",
                },

                Boolean = {
                    italic = true,
                },

                ['@boolean'] = {
                    link = "Boolean",
                },

                ['@variable'] = {
                    bold = true,
                },

                ['@lsp.type.variable'] = {
                    link = "@variable",
                },

                ['@parameter'] = {
                    italic = true,
                },

                ['@variable.parameter'] = {
                    link = "@parameter",
                },

                -- TODO FIXME NOTE
                StatusLineMode = {
                    fg = '#fc9867',
                    link = 'StatusLine',
                },

                ToggleTermNormal = {
                    bg = bg_dark,
                },

                ToggleTermStatusLine = {
                    link = "StatusLine",
                },
            }
        end,
    })

    monokai_pro.load()

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "Visual", { bg = "#6b5000" })
    -- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#6b5000" })
    -- vim.api.nvim_set_hl(0, "Cursor", { bg = "#fc9867", fg = "#fc9867" })
end

return M
