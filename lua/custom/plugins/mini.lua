return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Jump to next/previous single character
      -- Extend f, F, t, T to work on multiple lines
      require('mini.jump').setup()

      -- Jump within visible lines using 2-character search
      -- Similar to hop.nvim or leap.nvim
      -- Popular keybindings: jj (jump), jl (jump line), jw (jump word)
      local jump2d = require 'mini.jump2d'
      jump2d.setup {
        -- Function producing jump spots (byte indexed) for a particular line.
        spotter = nil,
        -- Characters used for labels of jump spots (in supplied order)
        labels = 'abcdefghijklmnopqrstuvwxyz',
        -- Which lines are used for computing jump spots
        allowed_lines = {
          blank = true, -- Blank line (not sent to spotter even if `true`)
          cursor_before = true, -- Lines before cursor line
          cursor_at = true, -- Cursor line
          cursor_after = true, -- Lines after cursor line
          fold = true, -- Start of fold (not sent to spotter even if `true`)
        },
        -- Which windows are used for visible lines
        allowed_windows = {
          current = true,
          not_current = true,
        },
        -- Functions to be executed at certain events
        hooks = {
          before_start = nil, -- Before jump start
          after_jump = nil, -- After jump was done
        },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          start_jumping = '', -- Disable default, we'll use custom mappings below
        },
      }

      -- Custom jump2d keymaps
      vim.keymap.set('n', 'jj', '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>', { desc = 'Jump to character' })
      vim.keymap.set('n', 'jl', '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.line_start)<CR>', { desc = 'Jump to line' })
      vim.keymap.set('n', 'jw', '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>', { desc = 'Jump to word' })


      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Simple and fast start screen
      -- Shows recent files, sessions, and other useful shortcuts
      local starter = require 'mini.starter'
      starter.setup {
        -- Whether to open starter buffer on VimEnter. Not opened if Neovim was started with intent to show something else
        autoopen = true,
        -- Whether to evaluate action of single active item
        evaluate_single = false,
        -- Items to be displayed. Should be an array with the following elements:
        -- - Item: table with <action>, <name>, and <section> keys.
        -- - Function: should return one of these three categories.
        -- - Array: elements of these three types (i.e. item, array, function).
        items = {
          -- Telescope section
          { name = 'Find Files                    ', action = 'Telescope find_files', section = '🔭 Telescope' },
          { name = 'Live Grep                     ', action = 'Telescope live_grep', section = '🔭 Telescope' },
          { name = 'Recent Files                  ', action = 'Telescope oldfiles', section = '🔭 Telescope' },
          { name = 'Projects                      ', action = 'Telescope projects', section = '🔭 Telescope' },
          
          -- Quick Actions section
          { name = 'File Browser (Oil)            ', action = 'Oil --float', section = '⚡ Quick Actions' },
          { name = 'File Tree (Neo-tree)          ', action = 'Neotree reveal', section = '⚡ Quick Actions' },
          { name = 'New File                      ', action = 'enew', section = '⚡ Quick Actions' },
          { name = 'Config                        ', action = 'edit $MYVIMRC | cd %:p:h', section = '⚡ Quick Actions' },
          
          -- Sessions
          starter.sections.sessions(8, true),
          
          -- Built-in actions
          starter.sections.builtin_actions(),
        },
        -- Header to be displayed before items. Converted to single string via `tostring` (use `\n` to display several lines).
        header = function()
          local hour = tonumber(vim.fn.strftime '%H')
          -- [04:00, 12:00) - morning, [12:00, 20:00) - day, [20:00, 04:00) - evening
          local part_id = math.floor((hour + 4) / 8) + 1
          local day_part = ({ 'evening', 'morning', 'afternoon', 'evening' })[part_id]
          local username = vim.loop.os_get_passwd()['username'] or 'USERNAME'
          
          -- ASCII art header
          local header_art = [[
    ███╗   ██╗██╗██████╗  ██████╗ 
    ████╗  ██║██║██╔══██╗██╔═══██╗
    ██╔██╗ ██║██║██████╔╝██║   ██║
    ██║╚██╗██║██║██╔══██╗██║   ██║
    ██║ ╚████║██║██████╔╝╚██████╔╝
    ╚═╝  ╚═══╝╚═╝╚═════╝  ╚═════╝ 
]]
          return header_art .. '\n' .. ('Good %s, %s'):format(day_part, username)
        end,
        -- Footer to be displayed after items. Converted to single string via `tostring` (use `\n` to display several lines).
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return string.format('⚡ Loaded %d/%d plugins in %.2fms', stats.loaded, stats.count, ms)
        end,
        -- Array of functions to be applied consecutively to initial content.
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          -- Removed indexing to hide numbers
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning('center', 'center'),
        },
      }

      -- Auto-open starter when last buffer is closed
      vim.api.nvim_create_autocmd('User', {
        pattern = 'BDeletePost*',
        callback = function(event)
          local fallback_name = vim.api.nvim_buf_get_name(event.buf)
          local fallback_ft = vim.api.nvim_buf_get_option(event.buf, 'filetype')
          local fallback_on_empty = fallback_name == '' and fallback_ft == ''

          if fallback_on_empty then
            vim.schedule(function()
              vim.cmd 'Starter'
            end)
          end
        end,
      })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
