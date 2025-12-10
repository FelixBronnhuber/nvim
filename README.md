# My personal NVIM Config

> [!IMPORTANT]
> Requires: **nvim >= 0.12** (uses `vim.pack`)
> 
> Install: `sudo snap install nvim --edge --classic`

## Plugins

- **[vim-sleuth](https://github.com/tpope/vim-sleuth):** Automatic indentation detection
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):** Language Server Protocol (LSP) support
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):** Syntax highlighting and parsing
- **[github-nvim-theme](https://github.com/projekt0n/github-nvim-theme):** Colorscheme (light & dark)
- **[blink.cmp](https://github.com/Saghen/blink.cmp):** Completion engine
- **[blink-cmp-copilot](https://github.com/giuxtaposition/blink-cmp-copilot):** GitHub Copilot source for blink.cmp
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim):** Git integration
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim):** Fuzzy finder
- **[telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim):** Telescope UI enhancements
- **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim):** Integrated terminal
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim):** Utility functions
- **[sidekick.nvim](https://github.com/folke/sidekick.nvim):** GitHub Copilot CLI integration
- **[codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim):** GitHub Copilot Chat
- **[codecompanion-history.nvim](https://github.com/ravitemer/codecompanion-history.nvim):** Persistent chat history for Copilot Chat
- **[mason.nvim](https://github.com/mason-org/mason.nvim):** LSP/DAP installer
- **[mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim):** Bridge between Mason and lspconfig
- **[typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim):** Typst live preview
- **[mini.icons](https://github.com/echasnovski/mini.icons):** Icon support
- **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):** Statusline
- **[no-neck-pain.nvim](https://github.com/shortcuts/no-neck-pain.nvim):** Centers the current buffer
- **[snacks.nvim](https://github.com/folke/snacks.nvim):** Indentation guides and file explorer
- **[fidget.nvim](https://github.com/j-hui/fidget.nvim):** LSP progress and notifications
- **[bufferline.nvim](https://github.com/akinsho/bufferline.nvim):** Buffer/tab management
- **[vimtex](https://github.com/lervag/vimtex):** LaTeX integration with Zathura viewer
- **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):** Markdown rendering
- **[mini.diff](https://github.com/nvim-mini/mini.diff):** Better git diff view
- **[lazydev.nvim](https://github.com/folke/lazydev.nvim):** Neovim Lua config includes
- **[which-key.nvim](https://github.com/folke/which-key.nvim):** Keymap preview
- **[csvview.nvim](https://github.com/hat0uma/csvview.nvim):** CSV viewer
- **[vim-fugitive](https://github.com/tpope/vim-fugitive):** Git tools (dependency of vim-flog)
- **[vim-flog](https://github.com/rbong/vim-flog):** Git branch viewer
- **[vim-surround](https://github.com/tpope/vim-surround.git):** Vim Surround

## System Dependencies

Some plugins require additional tools to be installed on your system:

> [!CAUTION]
> This list is likely incomplete!

- **rust-toolchain:** For dependencies and Rust LSP (rust-analyzer)
- **tree-sitter-cli:** Required for some Treesitter grammars (e.g., LaTeX)
  - Install: `cargo install tree-sitter-cli`
- **ripgrep:** Used by Telescope for fast searching
  - Install: `brew install ripgrep` or `cargo install ripgrep`
- **fd:** Used by Telescope for file finding
  - Install: `brew install fd`
- **typst:** Required for Typst preview
  - Install: `brew install typst`
- **Node.js:** Required for some LSP servers managed by Mason (e.g., ts_ls)
  - Install: `brew install node`
- **Zathura:** PDF viewer for VimTeX
  - Install: `brew install zathura zathura-pdf-poppler`
- **GitHub Copilot CLI:** For Sidekick integration
  - Install: `gh extension install github/gh-copilot`

