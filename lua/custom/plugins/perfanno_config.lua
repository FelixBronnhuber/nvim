return {}
-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end
--
-- local packer_bootstrap = ensure_packer()
--
-- vim.opt.rtp:append(vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim')
-- require('packer').startup(function(use)
--   use 'wbthomason/packer.nvim'
--   use 't-troebst/perfanno.nvim'
--
--   if packer_bootstrap then
--     require('packer').sync()
--   end
-- end)
--
-- vim.opt.rtp:append(vim.fn.stdpath 'data' .. '/site/pack/packer/start/perfanno.nvim')
-- local perfanno = require 'perfanno'
-- local util = require 'perfanno.util'
--
-- perfanno.setup {
--   line_highlights = util.make_bg_highlights(nil, '#FF2000', 10),
--   vt_highlight = util.make_fg_highlight '#FF2000',
-- }
--
-- local keymap = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }
--
-- keymap('n', '<LEADER>plf', ':PerfLoadFlat<CR>', opts)
-- keymap('n', '<LEADER>plg', ':PerfLoadCallGraph<CR>', opts)
-- keymap('n', '<LEADER>plo', ':PerfLoadFlameGraph<CR>', opts)
-- keymap('n', '<LEADER>pe', ':PerfPickEvent<CR>', opts)
-- keymap('n', '<LEADER>pa', ':PerfAnnotate<CR>', opts)
-- keymap('n', '<LEADER>pf', ':PerfAnnotateFunction<CR>', opts)
-- keymap('v', '<LEADER>pa', ':PerfAnnotateSelection<CR>', opts)
-- keymap('n', '<LEADER>pt', ':PerfToggleAnnotations<CR>', opts)
-- keymap('n', '<LEADER>ph', ':PerfHottestLines<CR>', opts)
-- keymap('n', '<LEADER>ps', ':PerfHottestSymbols<CR>', opts)
-- keymap('n', '<LEADER>pc', ':PerfHottestCallersFunction<CR>', opts)
-- keymap('v', '<LEADER>pc', ':PerfHottestCallersSelection<CR>', opts)
