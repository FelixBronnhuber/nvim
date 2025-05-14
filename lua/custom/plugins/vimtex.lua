return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    if vim.fn.has 'mac' == 1 then
      vim.g.vimtex_view_method = 'zathura_simple'
      vim.g.vimtex_view_zathura_use_synctex = 1
    else
      vim.g.vimtex_view_method = 'general'
    end
  end,
}
