# detect wsl and do wsl stuffs
if uname -r | grep -qi microsoft; then
    export PATH="$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
    # DISPLAY stuff
    if [ -z ${DISPLAY} ]; then
        export DISPLAY=:1
        tmux set-option -g update-environment DISPLAY
    fi
else
    export PATH=$PATH:"$HOME/.cargo/bin"
    # setxkbmap us
fi
fpath+=~/.config/zfunc

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
  export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

if [ $USER = "tanapol" ]; then
    DEFAULT_USER=tanapol
elif [ $USER = "zynaxsoft" ]; then
    DEFAULT_USER=zynaxsoft
fi
if [[ -n $SSH_CONNECTION ]]; then
    DEFAULT_USER=
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=240
ZSH_AUTOSUGGEST_USE_ASYNCa=YES
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

disable r

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
ZSH_CUSTOM=$HOME/.zsh-custom
source $ZSH_CUSTOM/catppuccin.zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
gitfast
git
zsh-autosuggestions
zsh-syntax-highlighting
history-substring-search
)

source $ZSH/oh-my-zsh.sh
if [[ -f /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH=$PATH:"$HOME/.local/bin"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
source $ZSH_CUSTOM/zsh_aliases.zsh
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export GPG_TTY=$(tty)
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
      print -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
      print -n "%{%k%}"
  fi

  print -n "%{%f%}"
  CURRENT_BG='' 

  #Adds the new line and ➜ as the start character.
  #printf "\n ➜";
  #printf "\n 🔥";
  printf "\n 🚀";
}
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey \^U backward-kill-line

unsetopt share_history
setopt AUTO_PUSHD

eval "$(dircolors $HOME/dotfiles/dircolors.solarized-dark)"

# aws completion
AWS_COMPLETER=$HOME/.local/bin/aws_zsh_completer.sh
if test -f $AWS_COMPLETER; then
    source $AWS_COMPLETER
fi
if test -f $(which aws_completer); then
    complete -C $(which aws_completer) aws
fi

eval $(ssh-agent) > /dev/null

if [ -f "$(which kubectl)" ]; then
    source <(kubectl completion zsh)
fi

# stop the ctrl-s behavior
# (it stop the output of the terminal, it could be resumed by ctrl-q)
stty stop undef
stty start undef

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --hidden --no-ignore""'
export FZF_CTRL_T_COMMAND='fd --hidden --no-ignore""'

eval "$(starship init zsh)"

cat ~/dotfiles/motd.txt

autoload -Uz compinit
compinit -u

true


if test -f /usr/bin/terraform; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C /usr/bin/terraform terraform
fi
