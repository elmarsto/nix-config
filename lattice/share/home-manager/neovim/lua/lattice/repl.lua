local repl = {}

function repl.setup(use)
      local nOrD = function(ts)
        local nodeOut
        if (ts) then
          nodeOut = { "ts-node" }
        else
          nodeOut = { "node" }
        end

        local nodeRoot = vim.fs.find({ 'node_modules', 'package.json', 'package-lock.json', 'yarn.lock' }, {
          upward = true,
          stop = vim.loop.os_homedir(),
          path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        })
        if (#nodeRoot == 0) then
          return { "deno", "repl" }
        end

        return nodeOut
      end
      local tsCmd = function(meta)
        return nOrD(true)
      end
      local jsCmd = function(meta)
        return nOrD(false)
      end
      require 'iron.core'.setup {
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = {
              command = { "nsh" }
            },
            javascript = {
              command = jsCmd,
            },
            javascriptreact = {
              command = jsCmd,
            },
            typescript = {
              command = tsCmd,
            },
            typescriptreact = {
              command = tsCmd,
            },
            nix = {
              command = { "nix", "repl" }
            },
            lua = {
              command = { "lua" }
            },
            fennel = {
              command = { "fennel" }
            },
            python = {
              command = { "ipython" }
            }
          },
          repl_open_cmd = require('iron.view').bottom(40),
        },
        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      }
end

return repl
