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

    HOME_ELEVEN = "r3100109";
    OFFICE_ELEVEN_UNLOCKED = "r3100114";
    OFFICE_ELEVEN_UNLOCKED2 = "r3100493";
    FREDERIC_UNIGRAF_ELEVEN = "r3100230";

    CI_1_ROKU = "r3100032";
    CI_2_BCM = "r3100221";
    CI_3_FIRE = "r3100008";
    CI_4_AMLOGIC = "r3100080";

  } else {});

  initExtraBeforeCompInit = ''
    # init nix env
    [ -f ~/.nix-profile/etc/profile.d/nix.sh ] && . ~/.nix-profile/etc/profile.d/nix.sh

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