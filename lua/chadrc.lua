-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = 'carbonfox',
  theme_toggle = { 'carbonfox', 'gruvbox_light' },

  hl_override = {
    Comment = { italic = true },
    ['@comment'] = { italic = true },
    Visual = { bg = '#333333' }, -- #AA4433
  },
}

-- M.nvdash = {
--   load_on_startup = true,
--   header = {
--     '                            ',
--     '    ▐ ▄  ▌ ▐·▪  • ▌ ▄ ·.    ',
--     '   •█▌▐█▪█·█▌██ ·██ ▐███▪   ',
--     '   ▐█▐▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·   ',
--     '   ██▐█▌ ███ ▐█▌██ ██▌▐█▌   ',
--     '   ▀▀ █▪. ▀  ▀▀▀▀▀  █▪▀▀▀   ',
--     '                            ',
--     '     (ノಠ益ಠ)ノ彡 ɯıʌu      ',
--     '                            ',
--     '     Powered By  eovim    ',
--     '                            ',
--   },
--
--   buttons = {
--     { txt = '  Search File', keys = 'Spc s f', cmd = 'Telescope find_files' },
--     { txt = '  Search Recent Files', keys = 'Spc s o', cmd = 'Telescope oldfiles' },
--     { txt = '  Search grep', keys = 'Spc s g', cmd = 'Telescope grep_string' },
--     { txt = '󱥚  Themes', keys = 'tt', cmd = ":lua require('nvchad.themes').open()" },
--   },
-- }

M.ui = {
  cmp = {
    lspkind_text = true,
    style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false,
    },
  },
  telescope = {
    style = 'bordered',
  },
  statusline = {
    theme = 'default', -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = 'block',
    order = nil,
    modules = nil,
  },
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { 'treeOffset', 'buffers', 'tabs', 'btns' },
    modules = nil,
    bufwidth = 21,
  },
}

-- Term
M.term = {
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.5, ['bo sp'] = 0.3, ['bo vsp'] = 0.5 },
  float = {
    row = 0.1,
    col = 0.1,
    width = 0.8,
    height = 0.7,
    border = 'single',
  },
}

M.lsp = { signature = true }

M.colorify = {
  enabled = true,
  mode = 'virtual', -- fg, bg, virtual
  virt_text = '󱓻 ',
  highlight = { hex = true, lspvars = true },
}

return M
