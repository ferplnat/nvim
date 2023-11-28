function ColorMyPencils(color)
	color = color or 'kanagawa'

    local require_color = string.format('colors.%s', color)
    require(require_color).apply()
end

ColorMyPencils('kanagawa')
