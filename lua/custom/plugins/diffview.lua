return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<CMD>DiffviewOpen<CR>', desc = '[G]it: Open [D]iff view' },
    { '<leader>gD', '<CMD>DiffviewClose<CR>', desc = '[G]it: Close [D]iff view' },
    { '<leader>gfh', '<CMD>DiffviewFileHistory %<CR>', desc = '[G]it: [F]ile [H]istory (current file)' },
    { '<leader>gFH', '<CMD>DiffviewFileHistory<CR>', desc = '[G]it: [F]ile [H]istory (repo)' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      merge_tool = {
        layout = 'diff3_mixed',
        disable_diagnostics = true,
        winbar_info = true,
      },
    },
  },
}
