--- A plugin that opens a terminal in a floating window.
-- This script provides functions to open and close floating windows
-- with configurable size and positioning.
-- Built from https://www.youtube.com/watch?v=5PIiKDES_wc
--
-- @script floaterm

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function open_floating_window(opts)
  -- initialize opts
  opts = opts or {}

  -- Get the editor dimensions
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  -- Default to 80% of the editor size if not provided
  local width = opts.width or math.floor(editor_width * 0.8)
  local height = opts.height or math.floor(editor_height * 0.8)

  -- Calculate the starting position
  local col = math.floor((editor_width - width) / 2)
  local row = math.floor((editor_height - height) / 2)

  -- Configure the window
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded', -- Optional: Choose 'rounded', 'single', 'double', or 'none'
  }

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
    print 'used old floating buffer'
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    print 'new floating buffer'
  end

  -- Define win
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    -- TODO: removeme
    -- print(vim.inspect(state.floating))
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create user command
vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

-- Create Keymap
vim.keymap.set('n', '<leader>ft', ':Floaterminal <CR>', { noremap = true, silent = true })
