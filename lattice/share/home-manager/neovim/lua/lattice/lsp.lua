local lsp = {}

function lsp.setup()
  require('nvim-lightbulb').setup({
    virtual_text = {
      enabled = true,
    },
    autocmd = {
      enabled = true,
    }
  })
  local nvim_lsp = require("lspconfig")

  require 'lsp-format'.setup {}
  -- declare local in this scope so we don't `require` every run of on_attach below
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- nvim_lsp.ast_grep.setup {
  --   capabilities = capabilities,
  -- }
  nvim_lsp.awk_ls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.bashls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.autotools_ls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.bufls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.ccls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.clangd.setup {
    capabilities = capabilities,
  }
  nvim_lsp.cmake.setup {
    capabilities = capabilities,
  }
  nvim_lsp.cucumber_language_server.setup {
    capabilities = capabilities,
  }
  nvim_lsp.cssls.setup {
    capabilities = capabilities,
  }
  -- nvim_lsp.contextive.setup {
  --   capabilities = capabilities,
  -- }
  -- nvim_lsp.denols.setup {
  --   capabilities = capabilities,
  -- }
  vim.g.markdown_fenced_languages = {
    "ts=typescript"
  }
  nvim_lsp.docker_compose_language_service.setup {
    capabilities = capabilities,
  }
  nvim_lsp.dockerls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.dotls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.efm.setup {
    capabilities = capabilities,
  }
  -- nvim_lsp.emmet_ls.setup {
  --   capabilities = capabilities,
  -- }
  nvim_lsp.eslint.setup {
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    capabilities = capabilities,
    init_options = { documentFormatting = true },
  }
  nvim_lsp.fennel_ls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.gopls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.graphql.setup {
    capabilities = capabilities,
  }
  nvim_lsp.hls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.html.setup {
    capabilities = capabilities,
  }
  nvim_lsp.htmx.setup {
    capabilities = capabilities,
  }
  nvim_lsp.jqls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.jsonls.setup {
    capabilities = capabilities,
    settings = {
      schemas = require "schemastore".json.schemas(),
      validate = { enable = true }
    }
  }
  nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- E.g.: For using `vim.*` functions, add vim.env.VIMRUNTIME/lua.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          }
        })
      end
      return true
    end
  }
  nvim_lsp.marksman.setup {
    capabilities = capabilities,
  }
  nvim_lsp.mdx_analyzer.setup {
    capabilities = capabilities,
  }
  nvim_lsp.nixd.setup {
    capabilities = capabilities,
  }
  nvim_lsp.nushell.setup {
    capabilities = capabilities,
  }
  nvim_lsp.perlls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.postgres_lsp.setup {
    capabilities = capabilities,
  }
  nvim_lsp.pyright.setup {
    capabilities = capabilities,
  }
  nvim_lsp.ocamllsp.setup {
    capabilities = capabilities,
  }
  nvim_lsp.qmlls.setup {
    capabilities = capabilities,
  }
  -- nvim_lsp.remark_ls.setup {
  --   capabilities = capabilities,
  -- }
  nvim_lsp.rust_analyzer.setup {
    capabilities = capabilities,
  }
  -- nvim_lsp.spectral.setup {
  --   capabilities = capabilities,
  -- }
  nvim_lsp.sqlls.setup {
    settings = {
      sqlls = {
        connections = { vim.g.lattice.sqlls.config }
      }
    }
  }
  nvim_lsp.stylelint_lsp.setup {
    filetypes = { "css" },
    settings = {
      stylelintplus = {}
    }
  }
  nvim_lsp.statix.setup {
    capabilities = capabilities,
  }
  nvim_lsp.svelte.setup {
    capabilities = capabilities,
  }
  nvim_lsp.taplo.setup {
    capabilities = capabilities,
  }
  nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx"
    },
  }
  -- nvim_lsp.vale_ls.setup {
  --   capabilities = capabilities,
  -- }
  nvim_lsp.vimls.setup {
    capabilities = capabilities,
  }
  nvim_lsp.yamlls.setup {
    capabilities = capabilities,
    filetypes = { "yaml", "yml" },
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
          -- TODO: docker-compose schema
        },
        format = {
          enable = true,
          singleQuote = false,
          bracketSpacing = true
        },
        validate = true,
        completion = true
      }
    }
  }
  require 'lspconfig'.zls.setup {
    capabilities = capabilities,
  }
  -- TODO: json schemas
  require("inc_rename").setup()
end

return lsp
