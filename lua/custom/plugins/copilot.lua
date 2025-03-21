return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true },
        panel = { enabled = false },
      }
      local cmp = require 'cmp'
      local config = cmp.get_config()
      table.insert(config.sources, {
        name = 'copilot',
      })
      cmp.setup(config)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
