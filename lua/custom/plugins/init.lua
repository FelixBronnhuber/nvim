-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      scroll = { enabled = true },
      dashboard = {
        sections = {
          {
            section = 'terminal',
            cmd = 'chafa ~/.config/nvim/res/rustacean.png --format symbols --symbols vhalf --size 60x17 --stretch',
            height = 17,
            padding = 1,
          },
          {
            pane = 1,
            icon = ' ',
            title = 'Git Status',
            section = 'terminal',
            enabled = true,
            cmd = 'git status --short --branch --renames',
            height = 8,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          {
            pane = 1,
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'startup' },
          },
        },
      },
    },
  },
}
