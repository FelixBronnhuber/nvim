vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.tabstop = 4
vim.opt.winborder = "rounded"
vim.g.havenerdfont = true

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>', '<Nop>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':wa<CR>:qa<CR>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/folke/neodev.nvim.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/vague2k/vague.nvim.git" },
	{ src = "https://github.com/Saghen/blink.cmp.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git" },
	{ src = "https://github.com/akinsho/toggleterm.nvim.git" },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	{ src = "https://github.com/olimorris/codecompanion.nvim.git" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim.git" },
	{ src = "https://github.com/echasnovski/mini.icons.git" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim.git" },
})

require("toggleterm").setup { float_opts = { border = 'curved' } }

local floatterm = require("toggleterm.terminal").Terminal:new { direction = 'float', hidden = true }
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set({ 'n', 't' }, '<A-i>', function()
	floatterm:toggle()
end, { desc = 'Toggle floating terminal' })

require("vague").setup { transparent = false, style = { strings = "none" }, }
vim.cmd("colorscheme vague")

require("neodev").setup()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
	settings = { Lua = { completion = { callSnippet = "Replace" } } },
})

require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "rust", "python", "typst" },
	modules = {},
	sync_install = false,
	auto_install = false,
	ignore_install = {},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
}

local servers = { "lua_ls", "rust_analyzer", "clangd", "pyright", "tinymist" }
require("mason").setup { ensure_installed = servers }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	}
end

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { source = true, },
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

require("blink.cmp").setup {
	sources = { default = { 'lsp', 'path' }, },
	completion = {
		menu = { draw = { treesitter = { "lsp" } }, },
		documentation = { auto_show = true, treesitter_highlighting = true, },
	},
	signature = { enabled = true, }
}

local gitsigns = require('gitsigns')
vim.keymap.set('n', '<leader>gB', gitsigns.blame)
vim.keymap.set('n', '<leader>gD', gitsigns.diffthis)

require("telescope").setup { defaults = { layout_config = { width = 0.91, } } }
require("telescope").load_extension("ui-select")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git stashes' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope git stashes' })
vim.keymap.set('n', '<leader>gk', builtin.keymaps, { desc = 'Telescope key maps' })
vim.keymap.set('n', '<leader>q', function()
	builtin.diagnostics({ wrap_results = true, line_width = "full" })
end, { desc = 'Telescope dianostics' })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(_)
		vim.lsp.inlay_hint.enable(true)
		vim.keymap.set('n', 'grd', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })
		vim.keymap.set('n', 'grr', builtin.lsp_references, { desc = 'Telescope LSP references' })
		vim.keymap.set('n', 'gri', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { desc = 'Telescope LSP declaration' })
		vim.keymap.set('n', 'gro', builtin.lsp_document_symbols, { desc = 'Telescope LSP document symbols' })
		vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { desc = 'Telescope LSP type definitions' })
	end
})

require("codecompanion").setup {}
vim.keymap.set('n', '<leader>cp', ':CodeCompanion<CR>', { desc = 'Open CodeCompanion' })
vim.keymap.set('n', '<leader>cc', ':CodeCompanionChat<CR>', { desc = 'Open CodeCompanion Chat' })

require("typst-preview").setup {}
vim.keymap.set('n', '<leader>vt', ':TypstPreview<CR>', { desc = 'View typst preview' })

vim.keymap.set('n', '<leader>rr', function()
	if not floatterm:is_open() then
		floatterm:toggle()
	end
	floatterm:send("cargo run\n")
end, { desc = 'Run cargo run in floating terminal' })

require('lualine').setup {}
