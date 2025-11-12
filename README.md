# My personal NVIM Config

> [!INFO] Requires
> **nvim >= 0.12** (uses `vim.pack`)

## Plugins

- **[vim-sleuth](https://github.com/tpope/vim-sleuth):** Automatic indentation detection
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):** Language Server Protocol (LSP) support
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** Syntax highlighting and parsing
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme.git):** Colorscheme (light & dark)
- **[blink.cmp](https://github.com/Saghen/blink.cmp):** Completion engine
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim):** Git integration
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim):** Fuzzy finder
- **[telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim):** Telescope UI enhancements
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim):** Integrated terminal
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim):** Utility functions
- **[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim):** For GitHub Copilot Chat
- **[codecompanion-history](https://github.com/ravitemer/codecompanion-history.nvim.git):** Persistant chat history for Copilot Chat
- **[mason.nvim](https://github.com/mason-org/mason.nvim):** LSP/DAP installer
- **[mason-lspconfig.nvim](https://github.com/mason-org/mason.nvim):** Bridge between `mason` and `lspconfig` plugin
- **[typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim):** Typst live preview
- **[mini.icons](https://github.com/echasnovski/mini.icons):** Icon support
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):** Statusline
- **[no-neck-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim):** Centers the current buffer
- **[snacks.nvim](https://github.com/folke/snacks.nvim):** Indentation guides
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim):** LSP notifications
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim):** Buffer/tab management
- **[texpresso.nvim](https://github.com/let-def/texpresso.vim)**: TeXpresso integration for LaTeX live preview
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):** Markdown rendering
- **[mini-diff](https://github.com/nvim-mini/mini.diff.git):** Better git diff view
- **[lazydev.nvim](https://github.com/folke/lazydev.nvim.git):** Neovim Lua config includes
- **[which-key.nvim](https://github.com/folke/which-key.nvim.git):** Keymap preview
- **[csview.nvim]("https://github.com/hat0uma/csvview.nvim.git"):** CSV viewer
- **[vim-fugitive]("https://github.com/tpope/vim-fugitive.git"):** Git Tools (Dependency of `vim-flog`)
- **[vim-flog]("https://github.com/rbong/vim-flog.git"):** Git Branch Viewer

## System Dependencies

Some plugins require additional tools to be installed on your system:

> [!CAUTION]
> This list is likely incomplete!

- **rust-toolchain:** For dependencies and rust LSP
- **tree-sitter-cli:** Required for some Treesitter grammars (e.g., LaTeX)
  - Install: `cargo install tree-sitter-cli`
- **ripgrep:** Used by Telescope for fast searching
  - Install: `brew install ripgrep` or `cargo install ripgrep`
- **fd:** Used by Telescope for file finding
  - Install: `brew install fd`
- **typst:** Required for Typst preview
  - `brew install typst`
- **Node.js:** Required for some LSP servers managed by Mason
  - Install: `brew install node`
- **TeXpresso (optional):** For Typst/LaTeX workflows
  - [Install instructions](https://github.com/let-def/texpresso/blob/main/INSTALL.md)
  - Set the environment variable `TEXPRESSO` to the path of the `texpresso` executable!
    - `export TEXPRESSO="path/to/bin/texpresso"`

