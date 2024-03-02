{ config, pkgs, lib, modulesPath, options, specialArgs, ... }:
let
  vimConfig = ''
    au CursorHold,CursorHoldI * :silent! checktime
    au FocusGained,BufEnter * :silent! checktime
    let &showbreak = '⮩'
    set autoread
    set backspace=indent,eol,start
    set expandtab
    set foldlevel=6
    set laststatus=2
    set list
    set listchars=precedes:«,extends:»
    set mouse=a
    set nospell
    set nu
    set relativenumber
    set shiftwidth=2
    set signcolumn=yes
    set smarttab
    set softtabstop=2
    set tabstop=2
    set termguicolors
    set undofile
    set wrap
  '';
in
{
  home.packages = with pkgs; [ neovide neovim-remote ];
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.unstable.vimPlugins;  [
        SchemaStore-nvim
        aurora
        blamer-nvim
        boole-nvim
        cmp-buffer
        cmp-cmdline
        cmp-dictionary
        cmp-emoji
        cmp-npm
        cmp-nvim-lsp
        cmp-nvim-lsp
        cmp-path
        cmp-rg
        cmp-spell
        cmp-treesitter
        cmp_luasnip
        comment-nvim
        copilot-cmp
        copilot-lua
        diffview-nvim
        dressing-nvim
        fidget-nvim
        formatter-nvim
        git-conflict-nvim
        gitsigns-nvim
        glow-nvim
        inc-rename-nvim
        indent-blankline-nvim
        iron-nvim
        legendary-nvim
        live-command-nvim
        lsp-format-nvim
        lspkind-nvim
        lualine-nvim
        luasnip
        luasnip
        marks-nvim
        mkdir-nvim
        mkdnflow-nvim
        mkdnflow-nvim
        neoscroll-nvim
        nui-nvim
        nvim-autopairs
        nvim-cmp
        nvim-cmp
        nvim-colorizer-lua
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-lightbulb
        nvim-lspconfig
        nvim-luadev
        nvim-luapad
        nvim-navbuddy
        nvim-navic
        nvim-notify
        nvim-scrollbar
        nvim-surround
        nvim-treesitter-refactor
        nvim-treesitter-textobjects
        nvim-treesitter-textsubjects
        nvim-treesitter.withAllGrammars
        nvim-unception
        nvim-web-devicons
        oil-nvim
        open-browser-vim
        plenary-nvim
        smart-splits-nvim
        specs-nvim
        sqlite-lua
        ssr
        telescope-frecency-nvim
        telescope-nvim
        telescope-project-nvim
        telescope-symbols-nvim
        telescope-undo-nvim
        todo-comments-nvim
        treesj
        trouble-nvim
        undotree
        venn-nvim
        vim-abolish
        vim-dadbod
        vim-dadbod-completion
        vim-dadbod-ui
        vim-fugitive
        vim-just
        vim-matchup
        vim-pencil
        vim-repeat
        vim-repeat
        vim-test
        winshift-nvim 
      ];
      withNodeJs = true;
      withPython3 = true;
      vimdiffAlias = true;
      extraLuaPackages = p: with p; [ luautf8 ];
      extraPackages = with pkgs.unstable; with nodePackages; [
        alejandra
        bash-language-server
        boost
        ccls
        cmake-language-server
        deno
        fennel
        graphql-language-service-cli
        jq-lsp
        llvm
        lua
        lua-fmt
        lua-language-server
        marksman
        nixd
        nsh
        python311Packages.ipython
        shellcheck
        sqls
        statix
        stylelint
        taplo
        tree-sitter
        typescript-language-server
        vale
        vim-language-server
        vscode-langservers-extracted
        yaml-language-server
        zls
        efm-langserver
        emmet-language-server
        docker-compose-language-service
        buf-language-server
        clang-tools # clangd
        cmake-language-server
        helm-ls
        fennel-ls
        jq-lsp
        htmx-lsp
        postgres-lsp
        rust-analyzer
        zk
        nushell
      ];
      extraConfig = ''
        ${vimConfig}
        au TermOpen * setlocal scrollback=-1
        set scrollback=100000
      '';
      extraLuaConfig = ''
        vim.g.lattice = {
          sqlls = {
            config = {
             driver = "postgresql",
             dataSourceName = "postgresql:///lattice"
            }
          },
        }
        local fn = vim.fn
        local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
          fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
          vim.cmd "packadd packer.nvim"
        end
        local packer = require "packer"
        require "packer.luarocks".install_commands()
        packer.startup {
          function(use)
            use "wbthomason/packer.nvim"
            require 'lattice'.setup(use)
          end
        }
      '';
    };
    vim = {
      enable = true;
      extraConfig = vimConfig;
    };
  };
  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };
}
