vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.swapfile = false
vim.o.tabstop = 8
vim.o.winborder = "rounded"
vim.g.havenerdfont = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.termguicolors = true

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
vim.keymap.set('n', '<leader>x', ':bd<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>y', '"+yy', { silent = true, noremap = true, desc = 'Yank line to clipboard' })
vim.keymap.set('v', '<leader>y', '"+y', { silent = true, noremap = true, desc = 'Yank selection to clipboard' })
vim.keymap.set('n', '<leader>Y', function()
	vim.cmd('normal! ggVG"+y')
	vim.notify('Yanked buffer to clipboard', vim.log.levels.INFO)
end, { desc = 'Yank entire buffer to clipboard' })

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == 'nvim-treesitter' and kind == 'update' then
			if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
			vim.cmd('TSUpdate')
		end
	end
})

vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name ~= 'blink.cmp' or (kind ~= 'install' and kind ~= 'update') then return end

		local path = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
		vim.notify("Building blink.cmp...", vim.log.levels.INFO)
		vim.system(
			{ "cargo", "build", "--release" },
			{ cwd = path },
			function(result)
				vim.schedule(function()
					if result.code == 0 then
						vim.notify("blink.cmp built successfully", vim.log.levels.INFO)
					else
						vim.notify("blink.cmp build failed:\n" .. (result.stderr or ""),
							vim.log.levels.ERROR)
					end
				end)
			end
		)
	end
})

vim.pack.add({
	{ src = "https://github.com/tpope/vim-sleuth.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	-- { src = "https://github.com/vague-theme/vague.nvim.git" },
	{
		src = "https://github.com/FelixBronnhuber/vague.nvim.git",
		version = "feat/light-mode"
	},
	{ src = "https://github.com/savq/melange-nvim.git" },
	{ src = "https://github.com/Saghen/blink.cmp.git" },
	{ src = "https://github.com/giuxtaposition/blink-cmp-copilot.git" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim.git" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim.git" },
	{ src = "https://github.com/akinsho/toggleterm.nvim.git" },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	{ src = "https://github.com/folke/sidekick.nvim.git" },
	{ src = "https://github.com/olimorris/codecompanion.nvim.git" },
	{ src = "https://github.com/ravitemer/codecompanion-history.nvim.git" },
	-- { src = "https://github.com/yetone/avante.nvim.git" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/nvim-neotest/nvim-nio.git" },
	{ src = "https://github.com/jay-babu/mason-nvim-dap.nvim.git" },
	{ src = "https://github.com/mfussenegger/nvim-dap.git" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui.git" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text.git" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim.git" },
	{ src = "https://github.com/echasnovski/mini.icons.git" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim.git" },
	{ src = "https://github.com/folke/snacks.nvim.git" },
	{ src = "https://github.com/j-hui/fidget.nvim.git" },
	{ src = "https://github.com/b0o/incline.nvim.git" },
	{ src = "https://github.com/lervag/vimtex.git" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git" },
	{ src = "https://github.com/nvim-mini/mini.diff.git" },
	{ src = "https://github.com/folke/lazydev.nvim.git" },
	{ src = "https://github.com/folke/which-key.nvim.git" },
	{ src = "https://github.com/hat0uma/csvview.nvim.git" },
	{ src = "https://github.com/tpope/vim-fugitive.git" },
	{ src = "https://github.com/rbong/vim-flog.git" },
	{ src = "https://github.com/tpope/vim-surround.git" },
	{ src = "https://github.com/midoBB/nvim-quicktype.git" },
	{ src = "https://github.com/MunifTanjim/nui.nvim.git" },
	{ src = "https://github.com/esmuellert/codediff.nvim.git" },
	{ src = "https://github.com/archie-judd/telescope-words.nvim.git" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim.git" },
	{ src = "https://github.com/duane9/nvim-rg.git" },
	{ src = "https://github.com/AckslD/nvim-neoclip.lua.git" },
	{ src = "https://github.com/kkharji/sqlite.lua" },
	{ src = "https://github.com/fdavies93/daily-notes.nvim.git" },
	{ src = "https://github.com/stevearc/oil.nvim.git" },
	{ src = "https://github.com/emrearmagan/dockyard.nvim.git" },
	{ src = "https://github.com/archie-judd/blink-cmp-words.git" },
	{ src = "https://github.com/Sang-it/fluoride.git" },
	{ src = "https://github.com/jbyuki/venn.nvim.git" },
	{ src = "https://github.com/erichlf/devcontainer-cli.nvim.git" },
	{ src = "https://github.com/Aietes/esp32.nvim.git" },
	{ src = "https://github.com/folke/todo-comments.nvim.git" },
	{ src = "https://github.com/folke/trouble.nvim.git" },
})

vim.keymap.set('n', '<leader>U', function()
	vim.pack.update()
end, { desc = 'Update pack (:w to apply)' })

local toggleterm = require("toggleterm")
toggleterm.setup { float_opts = { border = 'curved' } }

local Terminal = require("toggleterm.terminal").Terminal
local floatterm = Terminal:new { direction = 'float', hidden = true }
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
vim.keymap.set({ 'n', 't' }, '<A-i>', function()
	floatterm:toggle()
end, { desc = 'Toggle floating terminal' })

local btop_term
vim.keymap.set({ "n", "t" }, "<A-p>", function()
	if not btop_term then
		btop_term = Terminal:new({
			direction = "float", cmd = "btop", hidden = true, close_on_exit = true,
		})
		btop_term:open()
		return
	end

	if btop_term:is_open() then
		btop_term:shutdown()
		btop_term = nil
	else
		btop_term:open()
	end
end, { desc = "Toggle floating btop-terminal" })

vim.cmd("colorscheme melange")
-- vim.api.nvim_set_hl(0, "WinBar", { link = "Normal" })
-- vim.api.nvim_set_hl(0, "WinBarNC", { link = "Normal" })

local is_dark_theme = false
local function toggle_theme()
	if not is_dark_theme then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
	is_dark_theme = not is_dark_theme;
end
toggle_theme()
vim.keymap.set('n', 'tt', toggle_theme, { desc = "Toggle between light and dark theme" })

require("nvim-treesitter").setup({
	ensure_installed = {
		"c", "cpp", "lua",
		"vim", "vimdoc",
		"markdown", "rust", "python",
		"javascript", "java",
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	once = true,
	callback = function()
		require("lazydev").setup({
			library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
			integrations = { lspconfig = true, cmp = true },
		})
	end,
})

local servers = {
	"lua_ls", "rust_analyzer", "clangd", "pyright", "tinymist", "ts_ls", "jdtls", "texlab",
	"wgsl_analyzer"
}

require("mason").setup {}
require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
	automatic_enable = { exclude = servers },
}

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath('config')
			    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end
		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		})
	end,
})

for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		capabilities = capabilities,
	})
	vim.lsp.enable(server)
end

-- Trigger FileType for loaded buffers to ensure LSP attaches immediately
vim.schedule(function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype ~= "" then
			vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
		end
	end
end)

require("mason-nvim-dap").setup {
	ensure_installed = { "codelldb", "debugpy" },
	automatic_installation = true,
}
local dap = require("dap")

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		-- Mason installs codelldb here:
		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
		args = { "--port", "${port}" },
	}
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("nvim-dap-virtual-text").setup {}

local dapui = require('dapui')
dapui.setup()
vim.keymap.set('n', '<A-d>', function()
	dapui.toggle()
end, { desc = "Toggle Debug UI" })
vim.keymap.set('n', '<leader>dr', function()
	dap.toggle_breakpoint()
	dapui.toggle()
	dap.continue()
end, { desc = "Debug run to current line" })

vim.keymap.set('n', '<leader>db', function()
	dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

vim.keymap.set('n', '<leader>ds', function()
	dap.continue()
end, { desc = "DAP Start" })

vim.keymap.set('n', '<leader>dR', function()
	dap.restart()
end, { desc = "DAP Restart" })

vim.keymap.set('n', '<leader>dq', function()
	dap.stop()
end, { desc = "DAP Quit / Stop" })

local dap_keymaps = {
	{ 'n', '<Up>',      dap.step_out,      'DAP Step Out' },
	{ 'n', '<Down>',    dap.step_into,     'DAP Step Into' },
	{ 'n', '<Left>',    dap.continue,      'DAP Continue' },
	{ 'n', '<Right>',   dap.step_over,     'DAP Step Over' },
	{ 'n', '<S-Right>', dap.run_to_cursor, 'DAP Run to Cursor' },
}
local function set_dap_keymaps()
	for _, map in ipairs(dap_keymaps) do
		vim.keymap.set(map[1], map[2], map[3], { desc = map[4] })
	end
end
local function unset_dap_keymaps()
	for _, map in ipairs(dap_keymaps) do
		pcall(vim.keymap.del, map[1], map[2])
	end
end
dap.listeners.after.event_initialized["dap_keymaps"] = set_dap_keymaps
dap.listeners.after.event_terminated["dap_keymaps"] = unset_dap_keymaps
dap.listeners.after.event_exited["dap_keymaps"] = unset_dap_keymaps

local icons = {
	ERROR = '󰅚 ',
	WARN = '󰀪 ',
	INFO = '󰋽 ',
	HINT = '󰌶 ',
	DEBUG = ' ',
	NOTIFICATION = ' ',
	checkmark = ' ',
	x = ' ',
	FERRIS = ' ',
}

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.ERROR,
			[vim.diagnostic.severity.WARN] = icons.WARN,
			[vim.diagnostic.severity.INFO] = icons.INFO,
			[vim.diagnostic.severity.HINT] = icons.HINT,
		},
	},
})

local function yank_diag_message(register, notify_msg)
	local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diags = vim.diagnostic.get(0, { lnum = lnum })
	if #diags == 0 then
		vim.notify("No diagnostic on current line", vim.log.levels.INFO)
		return
	end
	vim.fn.setreg(register, diags[1].message)
	vim.notify(notify_msg, vim.log.levels.INFO)
end

vim.keymap.set("n", "yd", function()
	yank_diag_message('"', "Diagnostic copied")
end, { desc = "Yank diagnostic message" })

vim.keymap.set("n", "<leader>yd", function()
	yank_diag_message('+', "Diagnostic copied to clipboard")
end, { desc = "Yank diagnostic message" })

vim.keymap.set('n', 'gK', function()
	local new_config = not vim.diagnostic.config().underline
	vim.diagnostic.config({ underline = new_config })
end, { desc = 'Toggle diagnostic underline' })

vim.keymap.set("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })

vim.keymap.set("n", "<leader>Q", vim.diagnostic.setqflist, { desc = "Add buffer diagnostics to quickfix list" })

require("blink.cmp").setup {
	sources = {
		default = { 'lsp', 'path' },
		per_filetype = {
			markdown = { inherit_defaults = true, "dictionary" },
			text = { inherit_defaults = true, "dictionary" },
			typst = { inherit_defaults = true, "dictionary" },
			latex = { inherit_defaults = true, "dictionary" },
			lua = { inherit_defaults = true, 'lazydev' },
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
			thesaurus = {
				name = "blink-cmp-words",
				module = "blink-cmp-words.thesaurus",
			},
			dictionary = {
				name = "blink-cmp-words",
				module = "blink-cmp-words.dictionary",
			},
		},
	},
	completion = {
		menu = { draw = { treesitter = { "lsp" } }, },
		documentation = { auto_show = true, treesitter_highlighting = true, },
	},
	signature = { enabled = true, },
	fuzzy = { implementation = "prefer_rust_with_warning" },
}

local gitsigns = require('gitsigns')
gitsigns.setup {
	numhl = true,
}
vim.keymap.set('n', '<leader>gB', gitsigns.blame, { desc = 'Toggle git blame' })

require('mini.diff').setup {}
vim.keymap.set('n', '<leader>gd', MiniDiff.toggle_overlay, { desc = 'Toggle git diff overlay' })

vim.keymap.set('n', '<leader>gD', ':CodeDiff<CR>', { desc = 'Toggle git split code diff' })

local telescope = require("telescope")
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup {
	defaults = {
		layout_config = { width = 0.91, },
		color_devicons = true,
	},
}

telescope.load_extension("ui-select")
telescope.load_extension("todo-comments")
vim.keymap.set('n', '<leader> ', builtin.buffers, { desc = 'Telescope opened buffers' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sv', function()
	builtin.find_files({
		attach_mappings = function(_, _)
			actions.select_default:replace(actions.select_vertical)
			return true
		end,
	})
end, { desc = 'Telescope find files (split)' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Telescope keymap' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git stashes' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope git stashes' })
vim.keymap.set('n', '<leader>gk', builtin.keymaps, { desc = 'Telescope key maps' })
vim.keymap.set('n', '<leader>q', function()
	builtin.diagnostics({ wrap_results = true, line_width = "full" })
end, { desc = 'Telescope dianostics' })
vim.keymap.set('n', 'z=', builtin.spell_suggest, { noremap = true, desc = 'Telescope spell suggest' })
vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Telescope: search TODO/FIX/NOTE" })

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

require("codecompanion").setup {
	extensions = { history = { enabled = true } },
	display = {
		chat = {
			intro_message = "Blechdepp Chat",
		},
	},
}

vim.keymap.set(
	'n', '<leader>co',
	':CodeCompanionChat<CR>',
	{ noremap = true, desc = 'CodeCompanionChat Open' }
)
vim.keymap.set(
	'n', '<leader>ch',
	':CodeCompanionHistory<CR>',
	{ noremap = true, desc = 'CodeCompanionChat Open' }
)

require("sidekick").setup {
	nes = { enabled = false },
	cli = { win = { layout = "right" } },
}
local sidekick_cli = require('sidekick.cli')
vim.keymap.set({ 'n', 't' }, '<A-c>', function()
	sidekick_cli.toggle()
	vim.cmd('stopinsert')
end, { noremap = true, desc = 'Toggle Sidekick (Agent)' })

require("typst-preview").setup {}
vim.keymap.set('n', '<leader>vt', ':TypstPreview<CR>', { desc = 'View typst preview' })

local helpers = require 'incline.helpers'
local devicons = require 'nvim-web-devicons'
require('incline').setup {
	window = {
		padding = 0,
		margin = { horizontal = 0 },
	},
	render = function(props)
		-- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
		local fullpath = vim.api.nvim_buf_get_name(props.buf)
		local root = vim.fs.root(props.buf, { '.git', 'pyproject.toml', 'package.json' }) or vim.fn.getcwd()
		local filename = vim.fn.fnamemodify(fullpath, ':~:.')
		if fullpath:find('^' .. vim.pesc(root) .. '/') then
			filename = fullpath:sub(#root + 2) -- strip "<root>/"
		end
		if filename == '' then
			filename = '[No Name]'
		end
		local ft_icon, ft_color = devicons.get_icon_color(filename)
		local modified = vim.bo[props.buf].modified
		return {
			ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or
			'',
			' ',
			{ filename, gui = modified and 'bold,italic' or 'bold' },
			' ',
			-- guibg = '#44406e',
		}
	end,
}

require('lualine').setup {
	options = {
		section_separators = '', component_separators = '│',
	},
}

local snacks = require("snacks")
snacks.setup {
	indent = {
		enabled = true,
		indent = {
			priority = 1,
			enabled = true,
			char = '┊',
		},
		chunk = {
			enabled = true,
			char = {
				corner_top = "╭",
				corner_bottom = "╰",
				horizontal = "─",
				vertical = "│",
				arrow = "ᐅ",
			},
		},
		animate = {
			duration = 10,
			fps = 120,
		},
	},
	explorer = {
		enabled = true,
		replace_netrw = true,
		trash = true,
		hidden = true,
	},
	scroll = { enabled = true },
	zen = {
		toggles = {
			dim = false,
			git_signs = false,
			mini_diff_signs = false,
			diagnostics = false,
		},
		enabled = true,
	}
}
vim.keymap.set('n', '<leader>z', function() snacks.zen() end, { desc = 'Snacks Zen' })

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
	progress = { display = { done_icon = icons.checkmark } },
}

-- local bufferline = require("bufferline")
-- bufferline.setup {
-- 	options = {
-- 		-- Show more of the path for duplicate filenames
-- 		max_name_length = 40,
-- 		max_prefix_length = 30,
-- 		truncate_names = false,
-- 		-- Optionally, always show the parent folder for all files
-- 		name_formatter = function(buf)
-- 			local name = buf.name
-- 			local parent = vim.fn.fnamemodify(buf.path, ":h:t")
-- 			if parent ~= "." and parent ~= "" then
-- 				return parent .. "/" .. name
-- 			end
-- 			return name
-- 		end,
-- 		indicator = { style = 'none' },
-- 		separator_style = { '┊', '┊' },
-- 		show_buffer_close_icons = false,
-- 		always_show_bufferline = false,
-- 	}
-- }
vim.keymap.set('n', '<leader>M', ':Fidget history<CR>', { desc = 'Show fidget message history' })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { '*.tex', '*.typ', '*.md' },
	command = 'setlocal spell spelllang=en_us'
})

vim.keymap.set('n', '<leader>vs', function()
	if vim.wo.spell then
		vim.wo.spell = false
		vim.notify(icons.x .. ' Disabled spellcheck', vim.log.levels.INFO)
	else
		vim.wo.spell = true
		vim.o.spelllang = { 'en_us' }
		vim.notify(icons.checkmark .. 'Enabled spellcheck', vim.log.levels.INFO)
	end
end, { desc = 'Toggle spellcheck' })

require("render-markdown").setup {}

require("which-key").setup {
	delay = 800,
	win = { border = "rounded" }
}

require("csvview").setup {}
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.csv",
	command = "CsvViewEnable",
})
vim.api.nvim_create_user_command("LogHours", function()
	local file = os.getenv("NVIM_WORKHOURS_FILE")
	if file and file ~= "" then
		vim.cmd("edit " .. file)
	else
		vim.notify("NVIM_WORKHOURS_FILE is not set", vim.log.levels.ERROR)
	end
end, { desc = "Open work hours CSV file" })

-- Umlaute:
local chars = {
	a = 'ä',
	A = 'Ä',
	o = 'ö',
	O = 'Ö',
	u = 'ü',
	U = 'Ü',
	s = 'ß'
}
for key, val in pairs(chars) do
	vim.keymap.set('i', '<M-' .. key .. '>', val, { noremap = true, silent = true })
end

vim.keymap.set(
	"n",
	"<Leader>sd",
	telescope.extensions.telescope_words.search_dictionary,
	{ desc = "Telescope: search dictionary" }
)
vim.keymap.set(
	"n",
	"<Leader>sD",
	telescope.extensions.telescope_words.search_thesaurus,
	{ desc = "Telescope: search thesaurus" }
)

require("neoclip").setup {
	enable_persistent_history = true,
}
telescope.load_extension('neoclip')
vim.keymap.set(
	"n",
	"<Leader>h",
	telescope.extensions.neoclip.default,
	{ desc = "Telescope: search yank clipboard (history)" }
)

require("daily-notes").setup {}
vim.keymap.set('n', '<leader>nn', ":DailyNote<CR>", { desc = "New daily Note" })
vim.keymap.set('n', '<leader>sn', function()
	builtin.find_files({
		cwd = vim.fn.expand("~/daily-notes"),
		prompt_title = "Daily Notes",
	})
end, { desc = "Search Daily Notes" })

require("oil").setup {
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	columns = {
		"icon",
	},
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
	},
}
vim.keymap.set('n', '<leader>so', ":Oil<CR>", { desc = "Open Oil" })

require("dockyard").setup {}
vim.keymap.set('n', '<leader>dy', ":DockyardFloat<CR>", { desc = "Open Dock-Yard" })

require("fluoride").setup {
	window = {
		border = "rounded",
	},
}

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
	local venn_enabled = vim.inspect(vim.b.venn_enabled)
	if venn_enabled == "nil" then
		vim.b.venn_enabled = true
		vim.cmd [[setlocal ve=all]]
		-- draw a line on HJKL keystokes
		vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
		-- draw a box by pressing "f" with visual selection
		vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
	else
		vim.cmd [[setlocal ve=]]
		vim.api.nvim_buf_del_keymap(0, "n", "J")
		vim.api.nvim_buf_del_keymap(0, "n", "K")
		vim.api.nvim_buf_del_keymap(0, "n", "L")
		vim.api.nvim_buf_del_keymap(0, "n", "H")
		vim.api.nvim_buf_del_keymap(0, "v", "f")
		vim.b.venn_enabled = nil
	end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>vn', ":lua Toggle_venn()<CR>", { noremap = true })

require("devcontainer-cli").setup({
	-- only the most useful options shown; see full config below
	interactive = false,
	toplevel = true,
	remove_existing_container = true,
	-- dotfiles_repository = "https://github.com/erichlf/dotfiles.git",
	-- dotfiles_branch = "devcontainer-cli",devcontainercli
	-- dotfiles_targetPath = "~/dotfiles",
	-- dotfiles_installCommand = "install.sh",
	shell = "bash",
	nvim_binary = "nvim",
	log_level = "debug",
	console_level = "info",
})

require("todo-comments").setup {}
require("trouble").setup {}
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix (Trouble)" })

-- Init private work plugins:
require("private")
