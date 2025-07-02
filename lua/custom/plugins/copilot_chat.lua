return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      window = {
        title = 'Copilot Chat',
        border = 'rounded', -- 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
      },
      chat_autocomplete = true,
    },
    -- See Commands section for default commands if you want to lazy load on them
    init = function()
      require('CopilotChat').setup {}
    end,
  },
}
