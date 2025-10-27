-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>f', group = '[F]ind' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>S', group = '[S]ession' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        -- Code group (LSP + formatting)
        { '<leader>cf', desc = '[C]ode [F]ormat buffer', mode = 'n' },
        { '<leader>cf', desc = '[C]ode [F]ormat selection', mode = 'x' },
        { '<leader>tf', desc = '[T]oggle [F]ormat on save', mode = 'n' },
        { '<leader>ca', desc = '[C]ode [A]ction', mode = { 'n', 'x' } },
        { '<leader>rn', desc = '[R]e[n]ame symbol', mode = 'n' },

        -- Non-leader LSP navigations (documented for discoverability)
        { 'gd', desc = 'LSP: Goto Definition', mode = 'n' },
        { 'gD', desc = 'LSP: Goto Declaration', mode = 'n' },
        { 'gi', desc = 'LSP: Goto Implementation', mode = 'n' },
        { 'gt', desc = 'LSP: Goto Type Definition', mode = 'n' },
        { 'gr', desc = 'LSP: Find References', mode = 'n' },
        { 'K', desc = 'LSP: Hover', mode = 'n' },
        { '<C-k>', desc = 'LSP: Signature Help', mode = 'n' },
        { 'j', group = 'Jump (mini.jump2d)', mode = 'n' },
        { 'jj', desc = 'Jump to character', mode = 'n' },
        { 'jl', desc = 'Jump to line', mode = 'n' },
        { 'jw', desc = 'Jump to word', mode = 'n' },
        { 'f', desc = 'Jump forward to char (mini.jump)', mode = { 'n', 'x', 'o' } },
        { 'F', desc = 'Jump backward to char (mini.jump)', mode = { 'n', 'x', 'o' } },
        { 't', desc = 'Jump forward until char (mini.jump)', mode = { 'n', 'x', 'o' } },
        { 'T', desc = 'Jump backward until char (mini.jump)', mode = { 'n', 'x', 'o' } },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
