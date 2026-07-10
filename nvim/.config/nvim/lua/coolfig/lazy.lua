-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return require('lazy').setup({
  -- for vim telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  -- colorscheme
  { 'catppuccin/nvim', as = 'catppuccin' },
  { 'rebelot/kanagawa.nvim', as = 'kanagawa' },

  -- transparent background
  { 'tribela/transparent.nvim' },

  -- treesitter for color hinting
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },

  -- harpoon for navigation
  { 'theprimeagen/harpoon' },

  -- for undo exploration
  { 'mbbill/undotree' },

  -- for git actions
  { 'tpope/vim-fugitive' },

  -- lsp pluggins from lsp-zero
  { 'mason-org/mason.nvim', opts = {} },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },

  -- for closing braces
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {},
  },

  -- flutter dev tools
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    debugger = {
      enabled = true,
      register_configurations = function(_)
        -- require("dap").configurations.dart = {}
        -- require("dap.ext.vscode").load_launchjs()
      end,
    },
  },

  -- latex
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.Tex_BibtexFlavor = 'biblatex'
      vim.g.Tex_MultipleCompileFormats = 'pdf,bib,pdf'
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_compiler_latexmk_engines = {
        ["_"] = "-pdflatex",
      }
      end
    },

  -- debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- optional
      -- 'mason-org/mason.nvim',
      -- 'jay-babu/mason-nvim-dap.nvim',

      -- Language-specific debuggers
      'leoluz/nvim-dap-go', -- Golang
      'mxsdev/nvim-dap-vscode-js', -- js

      {
        'mrcjkb/rustaceanvim',
        version = '^6', -- Recommended
        lazy = false, -- This plugin is already lazy
      },

      -- Shows variable values inline as virtual text
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- optional
      -- require('mason-nvim-dap').setup {
      --     automatic_installation = true,
      --     handlers = {},
      --     ensure_installed = {
      --         'delve',
      --     },
      -- }

      -- Dap UI setup
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '⏸',
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

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Setup virtual text to show variable values inline
      require("nvim-dap-virtual-text").setup()

      require('dap-go').setup({
        delve = {
          -- Use Mason's delve installation with fallback to system delve
          path = "dlv",

          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          -- detached = vim.fn.has 'win32' == 0,
        }
      })
      require('dap-vscode-js').setup({
        debugger_path = os.getenv('HOME') .. '/development/javascript/vscode-js-debug',
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })
      
      for _, language in ipairs({ 'typescript', 'javascript' }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            port = "${port}",
            executable = {
              command = 'node',
              args = {
                os.getenv('HOME') .. '/development/javascript/vscode-js-debug/out/src/vsDebugServer.js',
                '${port}',
              },
            },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            os.getenv('HOME') .. '/development/javascript/vscode-js-debug/out/src/vsDebugServer.js',
            '${port}',
          }
        },
      }
    end,
  },
})
