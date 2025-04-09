---@type Base46Table
local M = {}
-- UI
M.base_30 = {
  white = '#d9dfe7', -- editor.foreground
  black = '#171f2b', -- editor.background
  darker_black = '#10151d', -- sideBar.background
  black2 = '#10151d', -- titleBar.inactiveBackground
  one_bg = '#1f2939', -- textBlockQuote.border / input.background
  one_bg2 = '#1f2939', -- dropdown.background
  one_bg3 = '#d9dfe7', -- fallback lighter bg
  grey = '#a4afbd', -- textPreformat.foreground
  grey_fg = '#8b98a9', -- descriptionForeground
  grey_fg2 = '#3d495a', -- checkbox.border
  light_grey = '#333e4f', -- panel.border
  red = '#f76769', -- errorForeground
  baby_pink = '#b895fd', -- button.hoverBackground
  pink = '#c8aaff', -- textLink.activeForeground
  line = '#333e4f', -- titleBar.border
  green = '#17b877', -- terminal.ansiGreen
  vibrant_green = '#66ce98', -- terminal.ansiBrightGreen
  nord_blue = '#171f2b', -- activityBar.background
  blue = '#a87ffb', -- activityBarBadge.background
  seablue = '#333e4f', -- textCodeBlock.background
  yellow = '#ffb256', -- list.warningForeground
  sun = '#fa7b7c', -- list.errorForeground
  purple = '#8964e8', -- focusBorder
  dark_purple = '#a87ffb', -- alternate blue/purple
  teal = '#25a6e9', -- terminal.ansiCyan
  orange = '#ffa23e', -- terminal.ansiYellow
  cyan = '#25a6e9', -- terminal.ansiCyan
  statusline_bg = '#1f2939', -- statusBar.background
  lightbg = '#10151d', -- sideBarSectionHeader.background
  pmenu_bg = '#8964e8', -- progressBar.background
  folder_bg = '#10151d', -- fallback
}

M.base_16 = {
  base00 = '#171f2b', -- background
  base01 = '#10151d',
  base02 = '#1f2939',
  base03 = '#333e4f',
  base04 = '#475365',
  base05 = '#d9dfe7', -- foreground
  base06 = '#a4afbd',
  base07 = '#fafbfe',
  base08 = '#f76769', -- red
  base09 = '#ffb256', -- orange
  base0A = '#fd8da3', -- yellow
  base0B = '#17b877', -- green
  base0C = '#25a6e9', -- cyan
  base0D = '#a87ffb', -- blue
  base0E = '#8964e8', -- purple
  base0F = '#ffc6d0', -- accent
}

M.polish_hl = {
  defaults = {
    Comment = { fg = '#7f8d9f', italic = true },
  },
  treesitter = {
    ['@variable'] = { fg = '#ffb256' },
    ['@function'] = { fg = '#a87ffb' },
    ['@keyword'] = { fg = '#fd8da3' },
  },
}

M.type = 'dark'

M = require('base46').override_theme(M, 'monospace_dark')

return M
