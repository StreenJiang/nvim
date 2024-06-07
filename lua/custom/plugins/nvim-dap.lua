return {
  'mfussenegger/nvim-dap',
  dependencies = { 'jay-babu/mason-nvim-dap.nvim' },
  config = function()
    local dap = require 'dap'

    -- Reset display of breakpoint
    vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
    -- Key mappings
    vim.keymap.set('n', '<F5>', function()
      require('dap').continue()
    end, { desc = '' })
    vim.keymap.set('n', '<F10>', function()
      require('dap').step_over()
    end, { desc = '' })
    vim.keymap.set('n', '<F11>', function()
      require('dap').step_into()
    end, { desc = '' })
    vim.keymap.set('n', '<F12>', function()
      require('dap').step_out()
    end, { desc = '' })
    vim.keymap.set('n', '<Leader>b', function()
      require('dap').toggle_breakpoint()
    end, { desc = 'nvim-dap: toggle_breakpoint' })
    vim.keymap.set('n', '<Leader>B', function()
      require('dap').set_breakpoint()
    end, { desc = 'nvim-dap: set_breakpoint' })
    vim.keymap.set('n', '<Leader>lp', function()
      require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = '' })
    vim.keymap.set('n', '<Leader>dr', function()
      require('dap').repl.open()
    end, { desc = '' })
    vim.keymap.set('n', '<Leader>dl', function()
      require('dap').run_last()
    end, { desc = '' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, { desc = '' })
    vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, { desc = '' })
    -- vim.keymap.set('n', '<Leader>df', function() require('dap.ui.widgets').centered_float(widgets.frames) end, {desc = ""})
    -- vim.keymap.set('n', '<Leader>ds', function() require('dap.ui.widgets').centered_float(widgets.scopes) end, {desc = ""})

    require('mason-nvim-dap').setup {
      ensure_installed = { 'netcoredbg', 'python' },
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        coreclr = function(config)
          config.adapters = {
            type = 'executable',
            command = os.getenv 'USERPROFILE' .. '/AppData/Local/nvim-data/mason/packages/netcoredbg/netcoredbg/netcoredbg',
            args = {
              '--interpreter=vscode',
            },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = os.getenv 'USERPROFILE' .. '/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python',
            args = {
              '-m',
              'debugpy.adapter',
            },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      },
    }

    require('dap').set_log_level 'TRACE'

    -- dap.adapters.coreclr = {
    --   type = 'executable',
    --   command = 'usr/bin/netcoredbg',
    --   args = { '--interpreter=vscode' },
    -- }

    -- dap.configurations.cs = {
    --   {
    --     type = 'coreclr',
    --     name = 'launch - netcoredbg',
    --     request = 'launch',
    --     program = function()
    --       return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    --     end,
    --   },
    -- }

    vim.g.dotnet_build_project = function()
      -- local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
      local cmd = 'dotnet build -c Debug ' .. vim.fn.getcwd() .. '\\'
      if vim.fn.confirm('Continue to build dotnet project using cmd: ' .. cmd, '&yes\n&no', 2) == 1 then
        local exeResult = os.execute(cmd)
        if exeResult == 0 then
          print 'Build: ✔️ '
        else
          local ioResult = io.popen(cmd)
          if ioResult ~= nil then
            local out_put = ioResult:read '*all'
            print(out_put)
          end
        end
        -- local f = os.execute(cmd)
        -- if f == 0 then
        --     print('Build: ✔️ ')
        -- else
        --     print('Build: ❌ (code: ' .. f .. ')')
        -- end
      else
        print 'Build canceled'
      end
    end

    local config = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          local path_to_dll = vim.fn.getcwd() .. '\\OperationGuidance_new\\bin\\Debug\\net6.0-windows\\OperationGuidance_new.dll'
          -- local path_to_dll = vim.fn.getcwd() .. '\\ControllerTest\\bin\\Debug\\net6.0-windows\\ControllerTest.dll'
          -- local path_to_dll = vim.fn.getcwd() .. '\\ArmTest\\bin\\Debug\\net6.0-windows\\ArmTest.dll'
          -- local path_to_dll = vim.fn.getcwd() .. '\\SerialPortTest\\bin\\Debug\\net6.0-windows\\SerialPortTest.dll'
          return path_to_dll
          -- return 'D:\\VisualStudioProjects\\C#\\OperationGuidance_new\\OperationGuidance_new\\bin\\Debug\\net6.0-windows\\OperationGuidance_new.dll'
        end,
      },
    }
    dap.configurations.cs = config
    dap.configurations.fsharp = config

    vim.api.nvim_set_keymap('n', '<F4>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })
  end,
}
