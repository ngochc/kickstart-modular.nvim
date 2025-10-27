return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    default_mappings = false,
    disable_diagnostics = true,
    highlights = {
      incoming = 'DiffText',
      current = 'DiffAdd',
    },
  },
  config = function(_, opts)
    require('git-conflict').setup(opts)
    local map = function(lhs, rhs, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, lhs, rhs, { desc = desc })
    end
    map('<leader>gco', '<Plug>(git-conflict-ours)', '[G]it: Choose [O]urs')
    map('<leader>gct', '<Plug>(git-conflict-theirs)', '[G]it: Choose [T]heirs')
    map('<leader>gcb', '<Plug>(git-conflict-both)', '[G]it: Choose [B]oth')
    map('<leader>gc0', '<Plug>(git-conflict-none)', '[G]it: Choose N[0]ne')
    map('<leader>gcn', '<Plug>(git-conflict-next-conflict)', '[G]it: [N]ext conflict')
    map('<leader>gcp', '<Plug>(git-conflict-prev-conflict)', '[G]it: [P]revious conflict')
  end,
}
