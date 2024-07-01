-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    --
    -- Add your own debuggers here
    --TODO: add debuggers for other languages
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      ensure_installed = {
        'delve',
        'js-debug-adapter',
        'cpptools',
        'bash-debug-adapter',
      },
    }

    --configuration for delve debugger.
    --latest edit
    local delve = vim.fn.exepath "delve"
    if delve ~= "" then
      dap.adapters.mix_task = {
        type = "executable",
        command = delve,
    }

    dap.configurations.go = {
        {
          --TODO: check out more options for the delve debugger.
      type = "mix_task",
      request = "launch",
      name = "delve",
        },
    }
    end
    --latest change
    --TODO: make sure to uncomment the code below for go.
    --require('dap-go').setup{
     -- dap_configuraions = {
    --{
     --   type = "go",
      --  name = "Attatch remote",
       -- mode = "remote",
        --request = "attach",
        --},
      --},
      --delve = {
      --  path = "dlv",
       -- initialize_timeout_sec = 20,
        --port = "${port}",
        --args = {},
        --build_flags = "",
        --detatched = true,
        --cwd = nil,
      --},
    --}

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    ui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '||',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', ui.toggle, { desc = 'Debug: See last session result.' })

-- Open and close dapui automatically
dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end
    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
