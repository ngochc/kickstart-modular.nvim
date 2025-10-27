return {
  'catppuccin/nvim',
  name = 'catppuccin',
  enabled = true, -- Disable for now
  priority = 1000, -- Load before other plugins
  lazy = false, -- Load immediately on startup
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = {
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = 'dark',
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { 'italic' },
      conditionals = { 'italic' },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      mini = {
        enabled = true,
        indentscope_color = '',
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
      telescope = {
        enabled = true,
      },
      which_key = true,
      noice = true,
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    -- Set the colorscheme immediately after setup
    vim.cmd.colorscheme 'catppuccin'
    
    -- Force terminal colors
    vim.o.termguicolors = true
  end,
}
