-- ============================================================================
-- Gruvbox Theme - Old school dark theme with excellent readability
-- ============================================================================

return {
  "morhetz/gruvbox",
  priority = 1000,
  config = function()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_invert_selection = 0
    vim.g.gruvbox_sign_column = "bg0"
    vim.g.gruvbox_italic = 1
    vim.g.gruvbox_bold = 1
    vim.cmd([[colorscheme gruvbox]])
  end,
}
