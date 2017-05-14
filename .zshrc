# zsh theme
ZSH_THEME="eastwood"

# exports
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/Users/brennan/.oh-my-zsh
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=$(go env GOROOT)
source $HOME/.cargo/env
export PYTHONPATH=/usr/local/Cellar/python3/3.6.0_1/

# plugins
plugins=(git osx)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# enable vim mode
bindkey -v

# make backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# common keybindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# reduce lag when hitting <esc>
export KEYTIMEOUT=1

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# aliases
alias c="clear"
alias s="source ~/.zshrc"
alias ez="vim ~/.zshrc"

# functions
function mkd() {
  mkdir -p $1 && cd $1
}

function create-project() {
  mkdir -p ~/proj/$1 && cd ~/proj/$1 && git init
}
