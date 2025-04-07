local map = vim.keymap.set

-- Closes the buffer
map('n', '<leader>x', function()
  require('nvchad.tabufline').close_buffer()
end, { desc = 'buffer close' })

-- toggleable
map({ 'n', 't' }, '<A-v>', function()
  require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' }
end, { desc = 'terminal toggleable vertical term' })

map({ 'n', 't' }, '<A-h>', function()
  require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
end, { desc = 'terminal toggleable horizontal term' })

map({ 'n', 't' }, '<A-i>', function()
  require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
end, { desc = 'terminal toggle floating term' })

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
