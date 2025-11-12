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

vim.g.mapleader = " " -- Leader '<space>'
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>', '<Nop>', { silent = true, noremap = true, desc = 'Disable bare <leader>' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save current buffer' })
vim.keymap.set('n', '<leader>W', ':wa<CR>:qa<CR>', { desc = 'Save all and quit' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer with LSP' })
vim.keymap.set('n', '<leader>r', ':make<CR>', { desc = 'Run :make command' })
vim.keymap.set('n', '<leader>x', ':bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>y', '"+yy', { silent = true, noremap = true, desc = 'Yank line to clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true, noremap = true, desc = 'Yank selection to clipboard' })
vim.keymap.set('n', '<leader>Y', function()
	vim.cmd('normal! ggVG"+y')
	vim.notify('Yanked buffer to clipboard', vim.log.levels.INFO)
end, { desc = 'Yank entire buffer to clipboard' })

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/projekt0n/github-nvim-theme.git" },
	{ src = "https://github.com/Saghen/blink.cmp.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git" },
	{ src = "https://github.com/akinsho/toggleterm.nvim.git" },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	-- TODO: Switch to "https://github.com/folke/sidekick.nvim.git"
	{ src = "https://github.com/olimorris/codecompanion.nvim.git" },
	{ src = "https://github.com/ravitemer/codecompanion-history.nvim.git" },
	-- ***
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
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
	{ src = "https://github.com/folke/lazydev.nvim.git" },
	{ src = "https://github.com/folke/which-key.nvim.git" },
	{ src = "https://github.com/hat0uma/csvview.nvim.git" },
	{ src = "https://github.com/tpope/vim-fugitive.git" },
	{ src = "https://github.com/rbong/vim-flog.git" },
})

vim.keymap.set('n', '<leader>U', function()
	vim.pack.update()
end, { desc = 'Update pack (:w to apply)' })

require("toggleterm").setup { float_opts = { border = 'curved' } }

local floatterm = require("toggleterm.terminal").Terminal:new { direction = 'float', hidden = true }
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set({ 'n', 't' }, '<A-i>', function()
	floatterm:toggle()
end, { desc = 'Toggle floating terminal' })

require("github-theme").setup { options = { styles = { comments = 'italic' } } }

local is_dark_theme = true
vim.cmd("colorscheme github_dark_default")
vim.keymap.set('n', 'tt', function()
	if is_dark_theme then
		vim.cmd("colorscheme github_dark_default")
	else
		vim.cmd("colorscheme github_light")
	end
	is_dark_theme = not is_dark_theme;
end, { desc = "Toggle between light and dark theme" })

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"c", "cpp", "lua", "vim", "vimdoc", "markdown", "rust", "python", "typst", "javascript",
		"java", "latex", "wgsl"
	},
	modules = {},
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = { enable = true, additional_vim_regex_highlighting = false },
}

local servers = {
	"lua_ls", "rust_analyzer", "clangd", "pyright", "tinymist", "ts_ls", "jdtls", "texlab",
	"wgsl_analyzer"
}
require("mason").setup {}
require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
}

require("lazydev").setup {}

local icons = {
	ERROR = '󰅚 ',
	WARN = '󰀪 ',
	INFO = '󰋽 ',
	HINT = '󰌶 ',
	DEBUG = ' ',
	NOTIFICATION = ' ',
	DONE = ' ',
	FERRIS = ' ',
}

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true, -- Now handled by tiny-inline-diagnostics
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
vim.keymap.set('n', '<leader>gB', gitsigns.blame, { desc = 'Toggle git blame' })

require('mini.diff').setup {}
vim.keymap.set('n', '<leader>gd', MiniDiff.toggle_overlay, { desc = 'Toggle git diff overlay' })

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

require("codecompanion").setup { extensions = { history = { enabled = true } } }
vim.keymap.set('n', '<leader>cp', ':CodeCompanion<CR>', { desc = 'Open CodeCompanion' })
vim.keymap.set('n', '<leader>cc', ':CodeCompanionChat<CR>', { desc = 'Open CodeCompanion Chat' })

require("typst-preview").setup {}
vim.keymap.set('n', '<leader>vt', ':TypstPreview<CR>', { desc = 'View typst preview' })
require('lualine').setup {
	options = { section_separators = '', component_separators = '│' }
}

require("no-neck-pain").setup { width = 120, mappings = { enabled = true } }

local snacks = require("snacks")
snacks.setup {
	indent = {
		enabled = true,
		indent = {
			priority = 1,
			enabled = true,
			char = '┊',
			hl = 'SnacksIndent',
		},
	},
	explorer = {
		enabled = true,
		replace_netrw = true,
		trash = true,
	}
}
vim.keymap.set('n', '<A-\\>', function() snacks.explorer() end, { desc = 'Snacks explorer' })

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
		-- separator_style = { '│', '│' },
		separator_style = { '', '' },
		show_buffer_close_icons = false,
	}
}
vim.keymap.set('n', '<leader>M', ':Fidget history<CR>', { desc = 'Show fidget message history' })

-- Init private work plugins:
require("private")

local texpresso_env = os.getenv("TEXPRESSO") or ""
if texpresso_env ~= "" then
	require("texpresso").texpresso_path = texpresso_env
end

require("render-markdown").setup {}

require("which-key").setup { delay = 500 }

require("csvview").setup {}
