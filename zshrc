export PATH=$HOME/bin:/usr/local/bin:/Users/$USER/.nvm:/Users/alexstark/.nvm/versions/node/v6.3.1/lib:$HOME/.pyenv/shims/autopep8:~/flexport:$PATH
export DF=/Users/$USER/dotfiles
export ZSH=~/.oh-my-zsh
export FPT=$HOME/code-local/fp-tools

# use vim as the visual editor
export VISUAL=nvim
export EDITOR=nvim

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"


# Powerlevel Config
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true


source /usr/local/bin/virtualenvwrapper.sh

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git rails)

# zmv allows us to do some cool rename things
autoload -U zmv

# oh my zsh themes
source $ZSH/oh-my-zsh.sh

# syntax highlighter
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# path shortcuts
source $DF/paths.zsh

unsetopt correct_all

# autoenv
# source /usr/local/opt/autoenv/activate.sh

# custom commands
source $DF/commands/commands.zsh
source $DF/commands/fp-commands.zsh


alias gke='gke'
# flexport commands
alias devbox="$HOME/flexport/script/devbox.rb"
# ssh
export SSH_KEY_PATH="~/dotfiles/.ssh/rsa_id"

# load pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#load nvm
export NVM_DIR="/Users/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:$HOME/.rvm/bin:/Applications/MacVim.app/Contents/bin/mvim" # Add RVM to PATH for scripting

# make enter send return and not ^M TODO - figure out where this comes from
stty sane;
stty icrnl;

# vi mode in zsh
# bindkey -v
# bindkey -M vicmd '^R' history-incremental-search-backward
# bindkey '^R' history-incremental-search-backward


# Preserve Insert Cursor shape in nvim using iterm
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# ssh-add ~/.ssh/id_rsa


export PATH="$HOME/.yarn/bin:$PATH"
