vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.tabstop = 4
vim.opt.winborder = "rounded"

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.havenerdfont = true

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>', '<Nop>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':wa<CR>:qa<CR>')
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/folke/neodev.nvim.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/EdenEast/nightfox.nvim.git" },
	{ src = "https://github.com/Saghen/blink.cmp.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
	{ src = "https://github.com/dmtrKovalenko/fff.nvim.git" },
})

require("nightfox").setup({ options = { transparent = true } })
vim.cmd("colorscheme carbonfox")

require("neodev").setup()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
	settings = { Lua = { completion = { callSnippet = "Replace" } } }
})

require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "rust", "python" },
	modules = {},
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
}

vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd", "pyright" })

local function on_attach(client, bufnr)
	-- Inlay hints (available since Neovim 0.10+)
	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(bufnr, true)
	end

	-- Your keymaps
	local map = function(mode, lhs, rhs)
		vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr })
	end

	map('n', 'gd', vim.lsp.buf.definition)
	map('n', 'K', vim.lsp.buf.hover)
	map('n', '<leader>F', vim.lsp.buf.format)
end

vim.keymap.set('n', 'grd', vim.lsp.buf.definition)

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

require("blink.cmp").setup({
	fuzzy = { implementation = "lua", }
})

local gitsigns = require('gitsigns')
vim.keymap.set('n', '<leader>gb', gitsigns.blame)
vim.keymap.set('n', '<leader>gx', gitsigns.diffthis)

local fff = require('fff')
fff.setup({ prompt = "  " })
vim.keymap.set('n', '<leader>f', fff.find_files)
