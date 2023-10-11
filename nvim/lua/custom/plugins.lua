local plugins = {
  -- formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  -- LSP, code analysis, linting
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- 3rd party package manager
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cmake-language-server",
        "clangd",
        "clang-format",
        "codelldb",
        "pyright",
        "mypy",
        "ruff",
        "black",
        "debugpy",
      }
    }
  },
  -- Debug adaptor
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")  -- custom mappings
    end
  },
  -- Debug adaptor configurations
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    }
  },
  -- Debug adaptor UI
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- dapui.close()
      end
    end
  },
  -- CMake, Cargo, project packager and manager
  {
    "Shatur/neovim-tasks",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function ()
      require("custom.configs.tasks")
    end,
  },
  -- Copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    --config = function()
     -- require("custom.configs.copilot")
    --end
  },
  -- autosave
  {
    "pocco81/auto-save.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.autosave")
    end
  },
  -- lazygit plugin, install for your system
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("core.utils").load_mappings("lazygit")
    end
  },
  -- nvim dap python
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function ( )
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end
  },
  --"jamestthompson3/nvim-remote-containers",
  {
    "esensar/nvim-dev-container",
    -- "jamestthompson3/nvim-remote-containers",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = "VeryLazy",
    config = function ()
      require("devcontainer").setup{}
    end
  },
  {
    'pwntester/octo.nvim',
     dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    event = "VeryLazy",
    config = function ()
      require"octo".setup()
    end
  },
}
return plugins
