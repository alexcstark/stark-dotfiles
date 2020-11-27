# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$USER/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-in"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# use vim as the visual editor
export VISUAL=vim
export EDITOR="$VISUAL"

# zmv allows us to do some cool rename things
autoload -U zmv

# syntax highlighter
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unsetopt correct_all

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# make enter send return and not ^M TODO - figure out where this comes from
stty sane;
stty icrnl;

# Preserve Insert Cursor shape in nvim using iterm
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

function cd {
 builtin cd "$@";
 ls -a;
}

function gplom {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)

  if [[ "$BRANCH" == "master" ]]; then
    git pull origin master --rebase;
    return
  fi

  GS_OUTPUT=$(git status --porcelain)
  if [[ -n "$GS_OUTPUT" ]]; then
    echo "stashing detected changes"
    git stash; 
  fi
    
  git checkout master;
  git pull origin master --rebase --autostash;
  git checkout -;
  git rebase master;

  if [[ -n "$GS_OUTPUT" ]]; then
    git stash pop; 
  fi
}

function gc {
  git commit $1 $2;
}

function gs {
  git status;
}

function prof {
  vim ~/.zshrc;
}

function reprof {
 source ~/.zshrc;
}

BULLETTRAIN_PROMPT_ORDER=(
  time
  context
  dir
  git
)

alias awk1="awk '{print \$1}'"
alias awk2="awk '{print \$2}'"
alias awk3="awk '{print \$3}'"
alias awklast="rev | awk1 | rev"

alias ..="cd .."      # if you’re not using “.” for sourcing bash

alias c=clear

function ppjson {
  echo $@ | python -m json.tool;
}