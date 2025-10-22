vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.swapfile = false
vim.tabstop = 4
vim.opt.winborder = "rounded"
vim.g.havenerdfont = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

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
vim.keymap.set('n', '<leader>r', ':make<CR>')
vim.keymap.set('n', '<leader>x', ':bd<CR>')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>ya', function()
	vim.cmd('normal! ggVG"+y')
	vim.notify('Yanked buffer to clipboard', vim.log.levels.INFO)
end, { desc = 'Yank entire buffer to clipboard with message' })

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/folke/neodev.nvim.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/vague2k/vague.nvim.git" },
	{ src = "https://github.com/rose-pine/neovim.git" },
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
	{ src = "https://github.com/shortcuts/no-neck-pain.nvim.git" },
	{ src = "https://github.com/folke/snacks.nvim.git" },
	{ src = "https://github.com/j-hui/fidget.nvim.git" },
	{ src = "https://github.com/akinsho/bufferline.nvim.git" },
	{ src = "https://github.com/let-def/texpresso.vim.git" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git" },
	{ src = "https://github.com/nvim-mini/mini.diff.git" },
})

require("toggleterm").setup { float_opts = { border = 'curved' } }

local floatterm = require("toggleterm.terminal").Terminal:new { direction = 'float', hidden = true }
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set({ 'n', 't' }, '<A-i>', function()
	floatterm:toggle()
end, { desc = 'Toggle floating terminal' })

require("vague").setup { transparent = true, style = { strings = "none" }, }
vim.cmd("colorscheme vague")
require("rose-pine").setup { variant = 'dawn' }

-- Toggle between light and dark colorschemes
vim.api.nvim_set_keymap('n', '<Space>tt', [[:lua ToggleTheme()<CR>]], { noremap = true, silent = true })
local is_dark_theme = true
function ToggleTheme()
	is_dark_theme = not is_dark_theme
	if is_dark_theme then
		vim.cmd('colorscheme vague')
	else
		vim.cmd('colorscheme rose-pine-dawn')
	end
end

require("neodev").setup()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({
	settings = { Lua = { completion = { callSnippet = "Replace" } } },
})

require("nvim-treesitter.configs").setup {
	ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "markdown", "rust", "python", "typst", "javascript", "java", "latex" },
	modules = {},
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
}

local servers = { "lua_ls", "rust_analyzer", "clangd", "pyright", "tinymist", "ts_ls", "ntt", "jdtls", "texlab", "harper-ls" }
require("mason").setup { ensure_installed = servers }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	}
end

local icons = {
	ERROR = '󰅚 ',
	WARN = '󰀪 ',
	INFO = '󰋽 ',
	HINT = '󰌶 ',
	DEBUG = ' ',
	NOTIFICATION = ' ',
	DONE = ' ',
}

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { source = true, },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.ERROR,
			[vim.diagnostic.severity.WARN] = icons.WARN,
			[vim.diagnostic.severity.INFO] = icons.INFO,
			[vim.diagnostic.severity.HINT] = icons.HINT,
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
gitsigns.setup {}
vim.keymap.set('n', '<leader>gB', gitsigns.blame)

require('mini.diff').setup {}
vim.keymap.set('n', '<leader>gd', MiniDiff.toggle_overlay)

require("telescope").setup { defaults = { layout_config = { width = 0.91, } } }
require("telescope").load_extension("ui-select")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader> ', builtin.buffers, { desc = 'Telescope opened buffers' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Telescope keymap' })
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
require('lualine').setup {
	options = { section_separators = '', component_separators = '│' }
}

require("no-neck-pain").setup { width = 120, mappings = { enabled = true } }

require("snacks").setup {
	indent = {
		enabled = true,
		indent = {
			priority = 1,
			enabled = true,
			char = '┊',
			hl = 'SnacksIndent',
		},
	},
	image = {
		enabled = true,
	}
}

require("fidget").setup {
	notification = {
		configs = {
			default = vim.tbl_extend("force", require("fidget.notification").default_config, {
				icon = icons.NOTIFICATION,
				debug_annote = icons.DEBUG,
				error_annote = icons.ERROR,
				info_annote = icons.INFO,
				warn_annote = icons.WARN,
			}),
		},
		override_vim_notify = true,
		window = { winblend = 0, border = "rounded" },
	},
	progress = { display = { done_icon = icons.DONE } },
}

local bufferline = require("bufferline")
bufferline.setup {
	options = {
		indicator = { style = 'none' },
		separator_style = { '│', '│' },
		show_buffer_close_icons = false,
	}
}
vim.keymap.set('n', '<leader>M', ':Fidget history<CR>')

-- Init private work plugins:
require("private")

local texpresso_env = os.getenv("TEXPRESSO") or ""
if texpresso_env ~= "" then
	require("texpresso").texpresso_path = texpresso_env
end

require("render-markdown").setup {}
