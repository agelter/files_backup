{ pkgs, config, configName, isWorkMachine }: {
  enable = true;
  autosuggestion = {
    enable = true;
    highlight = "fg=8";
  };
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
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

  history = {
    expireDuplicatesFirst = true;
    ignoreDups = true;
    ignoreSpace = true;
    extended = true;
    path = "${config.xdg.dataHome}/zsh/history";
    share = false;
    size = 100000;
    save = 100000;
  };

  profileExtra = ''
      setopt incappendhistory
      setopt histfindnodups
      setopt histreduceblanks
      setopt histverify
      setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      setopt nocaseglob                                               # Case insensitive globbing
      setopt rcexpandparam                                            # Array expension with parameters
      #setopt nocheckjobs                                              # Don't warn about running processes when exiting
      setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      setopt appendhistory                                            # Immediately append history instead of overwriting
      unsetopt histignorealldups                                      # If a new command is a duplicate, do not remove the older one
      setopt interactivecomments
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       # Colored completion (different colors for dirs/files/etc)
      zstyle ':completion:*' rehash true                              # automatically find new executables in path
      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      mkdir -p "$(dirname ${config.xdg.cacheHome}/zsh/completion-cache)"
      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/completion-cache"
      zstyle ':completion:*' menu select
      WORDCHARS=''${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
    '';

  shellAliases = {
    grh = "git reset --hard HEAD";
    shelve = "git add -u && git commit --no-verify -m wip";
    ls = "lsd";
    l = "ls -l";
    la = "ls -a";
    lla = "ls -al";
    lt = "ls --tree";
    df = "duf";
    ssh = "ssh -Y";
    cat = "bat --paging=never";
    rg = "rg --hidden -g \"!.git\" -g \"!.yarn\"";
    dotfile_update = "function _df_update() { cd $DOTFILES_DIR; nix flake update; home-manager switch --flake \".#${configName}\" -b bk; }; _df_update";
  } // (if isWorkMachine then {
    connect_vpn = "sudo openvpn --config /etc/openvpn/lt.ovpn.netflix.net.201908.ovpn";
    fixpulse = "sudo launchctl unload -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist; sudo launchctl load -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist";

    # Eleven
    kssh = "kaiju-admin ssh";
    kssh_home_eleven = "kssh $HOME_ELEVEN";
    kssh_office_eleven_unlocked = "kssh $OFFICE_ELEVEN_UNLOCKED";
    kssh_frederic_unigraf_eleven = "kssh $FREDERIC_UNIGRAF_ELEVEN";

    kscp = "kaiju-admin scp";

    reboot_device = "function _reboot() { curl -X POST https://reboot.dta.netflix.com/v1/reboot -H \"Content-Type: application/json\" -d \"{\"query\":{\"devId\":\"$1\"}}\"; }; _reboot";
  } else {});

  sessionVariables = {
    # Shorter username at shell prompt
    DEFAULT_USER = "agelter";
    EDITOR = "nvim";
    COLORTERM = "truecolor";
    TERM = "screen-256color";

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

    DOTFILES_DIR = "${config.home.homeDirectory}/.dotfiles";
  } // (if isWorkMachine then {
    # Xilinx
    XILINXD_LICENSE_FILE = "2100@xilinx-license-server.nflxsdn.com";
    XILINX_INSTALL_DIR = "${config.home.homeDirectory}/Xilinx";

    # Newt
    NEWT_SKIP_VPNCHECK = "1";

    # Eleven
    SKIP_PLUGINS_TESTS = "1";

    HOME_ELEVEN = "r3100109";
    OFFICE_ELEVEN_UNLOCKED = "r3100114";
    OFFICE_ELEVEN_UNLOCKED2 = "r3100493";
    FREDERIC_UNIGRAF_ELEVEN = "r3100230";

    CI_1_ROKU = "r3100032";
    CI_2_BCM = "r3100221";
    CI_3_FIRE = "r3100008";
    CI_4_AMLOGIC = "r3100080";

  } else {});

  initExtra = ''
    source ~/.p10k.zsh

    # bind Ctrl-Space to auto-complete
    bindkey '^ ' autosuggest-accept

    ## Handle our own newlines so iTerm marks the right spot
    typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
    precmd() { echo; }

    # iTerm2
    test -e "${config.home.homeDirectory}/.iterm2_shell_integration.zsh" && source "${config.home.homeDirectory}/.iterm2_shell_integration.zsh"
  '' + (if isWorkMachine then ''

    # Newt
    eval "$(NEWT_OFFLINE=1 NEWT_QUIET=1 newt --completion-script-zsh)"

    function nflx_promote() (
      cd ${config.home.homeDirectory}/src/avtnt/rae-packagecloud &&
        newt exec node promote.js "$@"
    )
  '' else null);

}
