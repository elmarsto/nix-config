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
      withNodeJs = true;
      withPython3 = true;
      vimdiffAlias = true;
      extraLuaPackages = p: with p; [ luautf8 ];
      extraPackages = with pkgs; with nodePackages; [
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
        sqlite
        sqls
        stylelint
        taplo
        tree-sitter
        typescript-language-server
        vale
        vim-language-server
        vscode-langservers-extracted
        yaml-language-server
        zig
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
        vim.g.sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3.so"
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
  xdg.configFile."nvim" = {
    source = ./neovim;
    recursive = true;
  };
}