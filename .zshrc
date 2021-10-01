# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/agelter/.oh-my-zsh"

# Starship
eval "$(starship init zsh)"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"
#
## Powerlevel9k settings
#POWERLEVEL9K_MODE="awesome-patched"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(battery context virtualenv vcs newline dir)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs command_execution_time history time)
#POWERLEVEL9K_DIR_HOME_BACKGROUND='blue'
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='blue'
#POWERLEVEL9K_DIR_ETC_BACKGROUND='blue'
#POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='blue'
#POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
#POWERLEVEL9K_DIR_ETC_FOREGROUND='white'
#POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
#POWERLEVEL9K_VIRTUALENV_FOREGROUND='white'
#POWERLEVEL9K_VIRTUALENV_BACKGROUND='025'
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='025'

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  docker
  docker-compose
  git
  iterm2
  pyenv
  zsh-autosuggestions
  zsh-wakatime
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  #export EDITOR='mvim'
  export EDITOR='vim'
fi

# Shorter username at shell prompt
DEFAULT_USER=agelter

# Enable syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions highlight color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# bind Ctrl-Space to auto-complete
bindkey '^ ' autosuggest-accept

source ~/.zsh_aliases

# MacVim
export PATH=${PATH}:/Applications/MacVim.app/Contents/bin/

# Local bin
export PATH=${PATH}:~/bin

# prefer Brew python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# RAE
export SONY_DEV='NFANDROID2-PRV-SONYANDROIDTV2018M3-SONY=BRAVIA=4K=UR1-7644-FAD1038E75DA901E8564CFCCC6DACE49D8E383CD1D8195C238A7A9530B23928A'
export FIRE_TV='NFANDROID2-PRV-FTVCUBE2019-AMAZOAFTR-11776-2F4175064A7368525E0AB40F963C4BF7DB8746ED6B2E0A664715EDB5663C15AD'
export SONY_PROD='NFANDROID2-PRV-SONYANDROIDTV2019M3-SONY=BRAVIA=4K=UR2-10378-F37E43C1F2D250BE8A40F4B9526C42657CD27D5934A6585B3525198455E8271E'
export ROKU='RKU-466XX-YJ000U272719'
export HOME_TCL='RKU-CXXXXAX00100HCYGFP'
export RAE=r3001368.raehub.com

export TEST_DIR=nrdptest/tests

export DEVICETESTS_TOKEN="NjAzNzM0NTYxOTMxOkrGvUKFN6Ojik+Rzdgyiwn2P0YI"

# NTS
export NEBULA_HOME="~/src/nts-scripting-with-java8/gradle/wrapper"
#export NF_IDFILE="~/.idfile"

# don't share history
unsetopt share_history

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Newt
eval "$(NEWT_OFFLINE=1 NEWT_QUIET=1 newt --completion-script-zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NETFLIX_SKIP_TESTS='dta'

eval "$(NEWT_OFFLINE=1 NEWT_QUIET=1 newt --completion-script-zsh)"

# direnv
eval "$(direnv hook zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/agelter/.sdkman"
[[ -s "/Users/agelter/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/agelter/.sdkman/bin/sdkman-init.sh"
