local code = {}

function code.setup(use)
    use {
        "slim-template/vim-slim",
        config = function()
            vim.api.nvim_create_autocmd(
                {"BufNewFile", "BufRead"},
                {
                    pattern = {"*.slim"},
                    command = "set ft=slim"
                }
            )
        end
    }
    vim.api.nvim_create_autocmd(
        {"BufNewFile", "BufRead"},
        {
            pattern = {"*.arb"},
            command = "set ft=ruby"
        }
    )
    require("Comment").setup()
    require("config-local").setup {
        config_files = {".nvim.lua", ".nvimrc", ".exrc"},
        hashfile = vim.fn.stdpath("data") .. "/config-local",
        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
        silent = false, -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = false -- Lookup config files in parent directories
    }
    require("formatter").setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
            lua = {
                require("formatter.filetypes.lua").luafmt
            },
            -- markdown = {
            --     require("formatter.filetypes.markdown").prettierd
            -- },
            js = {
                require("formatter.filetypes.javascript").prettierd
            },
            ts = {
                require("formatter.filetypes.typescript").prettierd
            },
            yaml = {
                require("formatter.filetypes.yaml").prettierd
            },
            nix = {
                require("formatter.filetypes.nix").alejandra
            },
            python = {
                require("formatter.filetypes.python").black
            },
            rust = {
                require("formatter.filetypes.rust").rustfmt
            },
            sh = {
                require("formatter.filetypes.sh").shfmt
            },
            -- sql = {
            --     require("formatter.filetypes.sql").sqlfluff
            -- },
            toml = {
                require("formatter.filetypes.toml").taplo
            }
            -- ["*"] = {
            --     require("formatter.defaults").prettierd
            -- }
        }
    }
    vim.cmd [[
      augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost * FormatWrite
      augroup END
    ]]
    require("nvim-autopairs").setup(
        {
            disable_filetype = {"TelescopePrompt", "vim", "markdown", "guihua", "guihua_rust", "clap_input"}
        }
    )
    vim.filetype.add(
        {
            extension = {
                alloy = "hcl"
            }
        }
    )
end

return code
