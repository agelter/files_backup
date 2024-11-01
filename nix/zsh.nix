{ pkgs, config, isWorkMachine }: {
  enable = true;
  autosuggestion = {
    enable = true;
    highlight = "fg=8";
  };
  syntaxHighlighting.enable = true;

  initExtra = "source ~/.p10k.zsh";

  oh-my-zsh = {
    enable = true;
    theme = "powerlevel10k/powerlevel10k";
    plugins = [
      "colored-man-pages"
      "colorize"
      "command-not-found"
      "docker"
      "docker-compose"
      "git"
      "gitfast"
      "iterm2"
      "pyenv"
    ];
  };

  plugins = [
    {
      name = "zsh-wakatime";
      src = pkgs.fetchFromGitHub {
        owner = "wbingli";
        repo = "zsh-wakatime";
        rev = "master";
        sha256 = "QN/MUDm+hVJUMA4PDqs0zn9XC2wQZrgQr4zmCF0Vruk=";
      };
    }
    {                                                                                   
      name = "powerlevel10k";                                                           
      src = pkgs.zsh-powerlevel10k;                                                     
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
    }
  ];

  localVariables = {
    # Shorter username at shell prompt
    DEFAULT_USER = "agelter";

    # Use case-sensitive completion.
    CASE_SENSITIVE = true;

    # Define how often to auto-update (in days).
    UPDATE_ZSH_DAYS = "7";

    # Enable command auto-correction.
    ENABLE_CORRECTION = false;

    # Display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS = true;

    # Don't echo the command back to the console
    DISABLE_AUTO_TITLE = true;

    TERM = "screen-256color";

    # Local bin
    PATH = "$PATH:~/bin";
  } // (if isWorkMachine then {
    # Xilinx
    XILINXD_LICENSE_FILE = "2100@xilinx-license-server.nflxsdn.com";
    XILINX_INSTALL_DIR = "${config.home.homeDirectory}/Xilinx";

    # Eleven
    SKIP_PLUGINS_TESTS = "1";
  } else {});

  initExtraBeforeCompInit = ''
    # bind Ctrl-Space to auto-complete
    bindkey '^ ' autosuggest-accept

    ## Handle our own newlines so iTerm marks the right spot
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
    precmd() { echo; }

    # iTerm2
    test -e "${config.home.homeDirectory}/.iterm2_shell_integration.zsh" && source "${config.home.homeDirectory}/.iterm2_shell_integration.zsh"

    # Newt
    eval "$(NEWT_OFFLINE=1 NEWT_QUIET=1 newt --completion-script-zsh)"
    #export NEWT_SKIP_VPNCHECK=1

  '' + (if isWorkMachine then ''
    function nflx_promote() (
      cd ${config.home.homeDirectory}/src/avtnt/rae-packagecloud &&
        newt exec node promote.js "$@"
    )
  '' else null);

}