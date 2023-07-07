function ColorMyPencils(color)
	color = color or "monokai-pro"
	vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "Visual", { bg = "#6b5000" })
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#fc9867", fg = "#fc9867" })
end

ColorMyPencils()
