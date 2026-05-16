return {
  'obsidian-nvim/obsidian.nvim',
  -- version = '*', -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    conceal = 1,
    workspaces = {
      { name = '', path = '' },
      {
      },
      {
      },
    },
  },
  keys = {
    -- Neotest related mappings
    { '<leader>o', group = '🪨 Obsidian', nowait = true, remap = false },
    {
      '<leader>od',
      '<cmd>Obsidian dailies<cr>',
      desc = '[O]bsidian [d]ailies',
    },
    {
      '<leader>os',
      '<cmd>Obsidian quick_switch<cr>',
      desc = '[O]bsidian quick [s]witch',
    },
    {
      '<leader>so',
      '<cmd>[S]earch [O]bsidian<cr>',
      desc = 'Quick quick switch',
    },
  },
}
