return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup()

    vim.keymap.set('n', '<leader>nt', ':NvimTreeOpen<CR>', { noremap = true, silent = true, desc = 'Open Nvim-[t]ree' })
    vim.keymap.set('n', '<leader>nf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true, desc = 'Find [f]ile in file tree' })
    vim.keymap.set('n', '<leader>nc', ':NvimTreeCollapse<CR>', { noremap = true, silent = true, desc = 'Collapse Nvim-Tree' })
  end,
}
