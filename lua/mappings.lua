---@module 'snacks'
local map = vim.keymap.set

-- Closes the buffer
map('n', '<leader>x', function()
  vim.cmd 'bd'
end, { desc = 'buffer close' })

-- Telescope Git
map('n', '<leader>gs', function()
  require('telescope.builtin').git_status()
end, { desc = 'git status' })

map('n', '<leader>gc', function()
  require('telescope.builtin').git_commits()
end, { desc = 'git commits' })

-- Show the nvui theme picker
map('n', '<leader>tt', function()
  require('nvchad.themes').open()
end, { desc = 'nvui theme picker' })
