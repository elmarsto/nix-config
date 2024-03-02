local code = {}

function code.setup(use)
  use "averms/black-nvim"
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  }
  use "bfredl/nvim-luadev"
  use { "folke/trouble.nvim" }
  use { "mfussenegger/nvim-dap",
    requires = { -- TODO: break up into separate use blocks
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
      "jbyuki/one-small-step-for-vimkind",
      {
        "microsoft/vscode-js-debug",
        opt = true,
        run = "npm install --legacy-peer-deps && npm run compile"
      },
    },
    config = function()
      require "dap-vscode-js".setup({
        adapters = { 'pwa-chrome' },
        log_file_path = "/tmp/dap_vscode_js.log",
        log_file_level = vim.log.levels.INFO, -- Logging level for output to file. Set to false to disable file logging.
        log_console_level = vim.log.levels
            .INFO                             -- Logging level for output to console. Set to false to disable console output.
      })
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        require("dap").configurations[language] = {
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Chrome Launch",
          },
        }
        require("nvim-dap-virtual-text").setup({})
        require "dapui".setup()
      end
      -- one-small-step
      require 'dap'.configurations.lua = { {
        type = 'nlua',
        request = 'attach',
        name = 'attach to running neovim instance'
      } }
    end
  }
  use { "mhartington/formatter.nvim", config = function()
    require("formatter").setup {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        -- lua = {
        --   -- "formatter.filetypes.lua" defines default configurations for the
        --   -- "lua" filetype
        --   require("formatter.filetypes.lua").stylua,
        --
        --   -- You can also define your own configuration
        --   function()
        --     -- Supports conditional formatting
        --     if util.get_current_buffer_file_name() == "special.lua" then
        --       return nil
        --     end
        --
        --     -- Full specification of configurations is down below and in Vim help
        --     -- files
        --     return {
        --       exe = "stylua",
        --       args = {
        --         "--search-parent-directories",
        --         "--stdin-filepath",
        --         util.escape_path(util.get_current_buffer_file_path()),
        --         "--",
        --         "-",
        --       },
        --       stdin = true,
        --     }
        --   end
        -- },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require("formatter.filetypes.any").remove_trailing_whitespace
        }
      }
    }
  end }
  use { "t-troebst/perfanno.nvim", config = function()
    require "perfanno".setup()
  end
  }
  use "vim-test/vim-test"
  use {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt", "vim", "markdown", "guihua", "guihua_rust", "clap_input" }
      })
    end
  }
end

return code
