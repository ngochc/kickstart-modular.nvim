return {
  'ruifm/gitlinker.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  opts = {
    mappings = nil,
    callbacks = nil,
    print_url = false,
    -- Use default hosters detection (GitHub/GitLab/Bitbucket etc.)
  },
  config = function(_, opts)
    local gitlinker = require 'gitlinker'
    local actions = require 'gitlinker.actions'
    gitlinker.setup(opts)
    -- Copy permalink for current line
    vim.keymap.set('n', '<leader>gy', function()
      gitlinker.get_buf_range_url('n', { action_callback = actions.copy_to_clipboard })
    end, { desc = '[G]it: Cop[y] permalink (line)' })
    -- Copy permalink for visual selection
    vim.keymap.set('v', '<leader>gy', function()
      gitlinker.get_buf_range_url('v', { action_callback = actions.copy_to_clipboard })
    end, { desc = '[G]it: Cop[y] permalink (selection)' })
  end,
}
