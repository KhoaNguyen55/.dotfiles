-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to clipboard' })

-- Ctrl + s = save
vim.keymap.set({ 'i', 'v', 'n' }, '<C-s>', '<cmd>:w %<CR>')

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Don't replace buffer when delete
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])
vim.keymap.set({ 'n', 'v' }, 'x', [["_x]])
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])

-- Do replace buffer
vim.keymap.set({ 'n', 'v' }, '<leader>d', 'd')
vim.keymap.set({ 'n', 'v' }, '<leader>x', 'x')

-- Full screen a buffer
vim.keymap.set('n', '<C-W>z', ':tabedit %<CR>', { desc = 'Expand the current buffer to be fullscreen' })

-- Make current script executable
vim.keymap.set('n', '<leader>chx', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make the current script executable' })

-- Tab indent
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- Search and replace word under cursor
vim.keymap.set('n', '<leader>fr', [[:%s/\V<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Find and replace word under cursor' })
vim.keymap.set('x', '<leader>fr', [[<Esc>:'<,'>s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Find and replace in range' })
vim.keymap.set('x', '<leader>fw', [["ay:%s/\V<C-r>a/<C-r>a/gI<Left><Left><Left>]], { desc = 'Find and replace word highlighted' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
