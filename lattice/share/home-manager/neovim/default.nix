{pkgs, ...}: let
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
    set nowrap
  '';
in {
  home.packages = with pkgs; [neovide neovim-remote live-server];
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.unstable.vimPlugins; [
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
        cmp-path
        cmp-rg
        cmp-spell
        cmp-treesitter
        cmp_luasnip
        comment-nvim
        diffview-nvim
        dressing-nvim
        fidget-nvim
        formatter-nvim
        # git-conflict-nvim # Disabled 2024 Oct 07; ironically, was causing conflicts
        gitsigns-nvim
        glow-nvim
        grug-far-nvim
        inc-rename-nvim
        indent-blankline-nvim
        iron-nvim
        legendary-nvim
        live-command-nvim
        lsp-format-nvim
        lspkind-nvim
        lualine-nvim
        luasnip
        marks-nvim
        mkdir-nvim
        mkdnflow-nvim
        neoscroll-nvim
        nui-nvim
        nvim-autopairs
        nvim-cmp
        nvim-colorizer-lua
        nvim-config-local
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-lightbulb
        nvim-lspconfig
        nvim-luadev
        nvim-luapad
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
        vim-gist
        vim-just
        vim-matchup
        vim-pencil
        vim-repeat
        vim-test
        winshift-nvim
      ];
      withNodeJs = true;
      withPython3 = true;
      vimdiffAlias = true;
      extraLuaPackages = p: with p; [luautf8];
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
  home.file = {
    ".vimrc".text = vimConfig;
  };
}
