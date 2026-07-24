local M = {}

local function apply_highlights()
	local float_bg = "#18181a"
	local border = "#3e3e43"

	vim.api.nvim_set_hl(0, "Visual", { bg = "#4a3b5c" })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = "#4a3b5c" })
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#2e3832" })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = "#3c342d" })
	vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#432d30" })
	vim.api.nvim_set_hl(0, "DiffText", { bg = "#554837" })
	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = float_bg })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = float_bg, fg = border })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#3e3e43" })
	vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = float_bg })
	vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = float_bg, fg = border })
	vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = float_bg, fg = border })
	vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = float_bg })
	vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = float_bg, fg = border })

	require("codediff.ui.highlights").setup()
end

function M.setup()
	vim.cmd.colorscheme("mellow")
	apply_highlights()

	local group = vim.api.nvim_create_augroup("MellowHighlights", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			if vim.g.colors_name == "mellow" then
				apply_highlights()
			end
		end,
	})
end

function M.ibl_rainbow_colors()
	return { 0x90b99f, 0xaca1cf, 0xe29eca, 0xea83a5, 0xf5a191, 0xe6b99d }
end

return M
