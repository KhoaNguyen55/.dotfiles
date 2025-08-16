return {
  'habamax/vim-godot',
  config = function()
    vim.lsp.enable 'gdscript'
    vim.keymap.set({ 'n', 'i' }, '<F4>', ':GodotRunLast<CR>', { buffer = true, desc = 'Godot Run Last Scene' })
    vim.keymap.set({ 'n', 'i' }, '<F5>', ':GodotRun<CR>', { buffer = true, desc = 'Godot Run Main Scene' })
    vim.keymap.set({ 'n', 'i' }, '<F6>', ':GodotRunCurrent<CR>', { buffer = true, desc = 'Godot Run Current Scene' })
    vim.keymap.set({ 'n', 'i' }, '<F7>', ':GodotRunFZF<CR>', { buffer = true, desc = 'Godot Run Searched Scene' })
  end,
}
