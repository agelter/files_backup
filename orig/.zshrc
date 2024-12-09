if [[ "$(arch)" = "arm64" ]]; then
    echo "Detected ARM ..."
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export PATH="/opt/homebrew/opt/curl/bin:$PATH"
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

    export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

    # use python3.10 for 'python'
    export PATH="/opt/homebrew/opt/python@3.10/libexec/bin:${PATH}"

    # use brew version of openssl
    export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

    # LLVM (clang-tidy, etc.)
    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
elif [[ "$(arch)" = "i386" ]]; then
    echo "Detected x86 ..."
    export HOMEBREW_PREFIX="/usr/local";
    export HOMEBREW_CELLAR="/usr/local/Cellar";
    export HOMEBREW_REPOSITORY="/usr/local/Homebrew";
    export PATH="/usr/local/bin:/usr/local/sbin${PATH+:$PATH}";
    export PATH="/usr/local/opt/curl/bin:$PATH"
    export MANPATH="/usr/local/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/usr/local/share/info:${INFOPATH:-}";

    export LDFLAGS="-L/usr/local/opt/curl/lib"
    export CPPFLAGS="-I/usr/local/opt/curl/include"

    # OpenSSL
    export PATH="/usr/local/opt/openssl@3/bin:$PATH"
    export LDFLAGS="${LDFLAGS+$LDFLAGS} -L/usr/local/opt/openssl@3/lib"
    export CPPFLAGS="${LDFLAGS+$LDFLAGS} -I/usr/local/opt/openssl@3/include"
elif [[ "$(arch)" = "x86_64" ]]; then
    echo "Detected x86_64 (linux) ..."
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "Unknown architecture."
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Define how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Don't echo the command back to the console
export DISABLE_AUTO_TITLE="true"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  colorize
  command-not-found
  docker
  docker-compose
  git
  gitfast
  iterm2
  pyenv
  zsh-autosuggestions
  zsh-wakatime
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

## Handle our own newlines so iTerm marks the right spot
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
precmd() { echo; }

# User configuration
# Shorter username at shell prompt
DEFAULT_USER=agelter

# Enable syntax highlighting
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# bind Ctrl-Space to auto-complete
bindkey '^ ' autosuggest-accept

source ~/.zsh_aliases

# Local bin
export PATH=${PATH}:~/bin

# prefer Brew python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# RAE
#export SONY_DEV='NFANDROID2-PRV-SONYANDROIDTV2018M3-SONY=BRAVIA=4K=UR1-7644-FAD1038E75DA901E8564CFCCC6DACE49D8E383CD1D8195C238A7A9530B23928A'
#export FIRE_TV='NFANDROID2-PRV-FTVCUBE2019-AMAZOAFTR-11776-2F4175064A7368525E0AB40F963C4BF7DB8746ED6B2E0A664715EDB5663C15AD'
#export SONY_PROD='NFANDROID2-PRV-SONYANDROIDTV2019M3-SONY=BRAVIA=4K=UR2-10378-F37E43C1F2D250BE8A40F4B9526C42657CD27D5934A6585B3525198455E8271E'
#export ROKU='RKU-466XX-YJ000U272719'
#export HOME_TCL='RKU-CXXXXAX00100HCYGFP'
#export RAE=r3001368.raehub.com

export TEST_DIR=nrdptest/tests

# NTS
export NEBULA_HOME="~/src/nts-scripting-with-java8/gradle/wrapper"
#export NF_IDFILE="~/.idfile"

# don't share history
unsetopt share_history

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export TERM=screen-256color

# 1password
eval "$(op completion zsh)"; compdef _op op
#source /home/agelter/.config/op/plugins.sh
export OP_PLUGIN_ALIASES_SOURCED=1

# gh completion
export PATH="${PATH}:/usr/local/share/zsh/site-functions/_gh"
autoload -U compinit
compinit -i
#eval "$(gh copilot alias -- zsh)"

gh_command() {
    # List of base directories where the -R option should be added for all subdirectories
    local base_dirs=("${HOME}/src/avtnt" "${HOME}/src/pax" "${HOME}/src/other")
    # List of gh subcommands that accept the -R option
    local subcommands_with_repo_option=("pr" "issue" "repo" "release")

    local current_dir="$PWD"
    local add_repo_flag=false

    for dir in "${base_dirs[@]}"; do
        if [[ "$current_dir" == "$dir"* ]]; then
            add_repo_flag=true
            break
        fi
    done

    local subcommand="$1"
    shift

    local use_repo_option=false
    for cmd in "${subcommands_with_repo_option[@]}"; do
        if [[ "$subcommand" == "$cmd" ]]; then
            use_repo_option=true
            break
        fi
    done

    local gh_command="op plugin run -- gh $subcommand"
    if [[ -e .git/ && "$add_repo_flag" == true && "$use_repo_option" == true ]]; then
        gh_command="$gh_command -R corp/$(basename "$PWD")"
    fi

    eval "$gh_command" "$@"
}
alias gh="gh_command"

# Newt
eval "$(NEWT_OFFLINE=1 NEWT_QUIET=1 newt --completion-script-zsh)"
#export NEWT_SKIP_VPNCHECK=1

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PVM
export NF_IDFILE="$HOME/.idfile"

export NETFLIX_SKIP_TESTS='dta'

# Xilinx
#export XILINXD_LICENSE_FILE="${HOME}/.local/.Xilinx/"
export XILINXD_LICENSE_FILE="2100@xilinx-license-server.nflxsdn.com"
export XILINX_INSTALL_DIR="${HOME}/Xilinx"

# Eleven
export SKIP_PLUGINS_TESTS=1

# For games tools
#export METADATA_PATH=/tmp
##export PE_TOOLS_DIR='${HOME}/src/games_pe_tools/tools/'
#
# direnv
eval "$(direnv hook zsh)"

# The Fuck
#eval $(thefuck --alias)
# Zoxide
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# set LS_COLORS
#source "${HOME}/.config/lsd/lscolors.sh"

function nflx_promote() (
  cd ${HOME}/src/avtnt/rae-packagecloud &&
    newt exec node promote.js "$@"
)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"


#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"


export OP_ACCOUNT="my"
