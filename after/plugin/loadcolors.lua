function ColorMyPencils(color)
    color = color or 'kanagawa'
    local require_color = string.format('colors.%s', color)
    require(require_color).apply()

    vim.api.nvim_set_hl(0, '@lsp.type.comment', {})
end

ColorMyPencils('tokyonight')
