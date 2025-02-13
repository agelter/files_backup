pkgs:
{
  enable = true;
  viAlias = true;
  vimAlias = true;
  plugins = with pkgs.vimPlugins; [
    editorconfig-vim
    LanguageClient-neovim
    vim-better-whitespace
    vim-wakatime
  ];

  extraConfig = ''
    colorscheme ron

    filetype plugin indent on
    syntax on

    set tabstop=4
    set shiftwidth=4
    set expandtab
    set hlsearch
    set incsearch
    set cindent
    set ruler

    set backspace=indent,eol,start

    cabbr <expr> %% expand('%:p:h')

    " Show trailing whitepace and spaces before a tab:
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
  '';
}
