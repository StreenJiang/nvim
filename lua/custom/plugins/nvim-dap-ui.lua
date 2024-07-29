return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('dapui').setup()

    vim.keymap.set('n', '<leader>ui', function()
      require('dapui').open()
    end, { desc = 'Open dap-ui' })
    vim.keymap.set('n', '<leader>uc', function()
      require('dapui').close()
    end, { desc = 'Close dap-ui' })
  end,
}
