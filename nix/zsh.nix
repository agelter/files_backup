{ pkgs, config, configName, isWorkMachine }: {
  enable = true;
  autosuggestion = {
    enable = true;
    highlight = "fg=8";
  };
  enableCompletion = true;
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
        sha256 = "iMHPDz4QvaL3YdRd3vaaz1G4bj8ftRVD9cD0KyJVeAs=";
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
    stop_cline = "newt --app-type mesh stop";
  } // (if isWorkMachine then {
    connect_vpn = "sudo openvpn --config /etc/openvpn/lt.ovpn.netflix.net.201908.ovpn";
    fixpulse = "sudo launchctl unload -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist; sudo launchctl load -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist";

    # Eleven
    kssh = "shelby ssh";
    ksshl = "shelby ssh --legacy";
    ksshd = "shelby ssh --direct";
    kssh_home_eleven = "kssh $HOME_ELEVEN";
    kssh_office_eleven_unlocked = "kssh $OFFICE_ELEVEN_UNLOCKED";
    kssh_frederic_unigraf_eleven = "kssh $FREDERIC_UNIGRAF_ELEVEN";

    kscp = "shelby scp";

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

    # graphite completion
    eval "$(gt completion)"

    function nflx_promote() (
      cd ${config.home.homeDirectory}/src/avtnt/rae-packagecloud &&
        newt exec node promote.js "$@"
    )

    builder_to_eleven() {
      local build_machine="XilinxBuilder"
      local remote_machine_user="$2"
      local artifact_path="$1"
      local artifact_name=$(basename "$artifact_path")

      scp "''${build_machine}:''${artifact_path}" "/tmp/''${artifact_name}" && \
      shelby scp "/tmp/''${artifact_name}" "''${remote_machine_user}:~/''${artifact_name}"
    }

    function setup_cline() {
      # Ensure VPN and Docker are running
      echo "Please ensure your VPN is connected and Docker is running."

      # Assign the provided project ID to a variable
      MODEL_GATEWAY_PROJECT_ID="eleveneyepatch"

      # Create the configuration file
      echo "Creating proxy configuration file..."
      cat << EOF > /tmp/proxy-config.yaml
apiVersion: "v1"
spec:
  meshServers:
    - name: foo
      config:
        localTargets:
          - name: lo_egress
            httpWorkload:
              port: 2002
              requestTimeoutMs: 0
        listeners:
        - name: strip_auth
          port: 7002
          handlers:
            - http:
                security:
                  plaintext: {}
                headers:
                  requestHeadersToRemove:
                    - "Authorization"
                defaultRoute:
                  localTargetName: lo_egress
EOF

      # Start the proxy
      echo "Starting the proxy..."
      newt --app-type mesh start -e prod -s /tmp/proxy-config.yaml

      # Test the connection
      echo "Testing the connection..."
      curl -vvv http://copilotdppython-secure.us-east-1.prod.svip.mesh.netflix.net:7002/proxy/$MODEL_GATEWAY_PROJECT_ID/v1/chat/completions \
          -H "content-type: application/json" \
          -d '{"model": "gpt-4o", "messages": [{"content": "foo", "role": "user"}]}'

      echo "\n\nSetup complete. Please configure the Cline extension in your IDE as per the instructions at https://go.netflix.com/cline"
  }

  function copy_ssh_pub_key() {
    local host=$1
    local pub_key=$(op item get $(op item list --format json | jq -r '.[] | select(.title | contains("Netflix SSH Key")) | .id') --format json | jq -r '.fields[] | select(.label=="public key") | .value')

    if [[ -z "$pub_key" ]]; then
      echo "Public key not found."
      return 1
    fi

    echo "mkdir -p ~/.ssh && echo \"$pub_key\" >> ~/.ssh/authorized_keys && sudo iptables -A INPUT -i eth0 -p tcp -m tcp --dport 22 -m comment --comment \"allow ssh over the WAN\" -j ACCEPT ; exit" | shelby ssh $host
  }

  '' else null);

}
