return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      -- { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          -- filetypes = {
          --   markdown = true,
          --   help = true,
          -- },
        },
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    init = function()
      require('CopilotChat').setup {
        chat_autocomplete = false,
      }
      -- Keymap for toggeling Copilot Chat
      vim.keymap.set('n', '<leader>cc', function()
        require('CopilotChat').toggle()
      end, { desc = 'Toggle Copilot Chat' })
    end,
  },
}
