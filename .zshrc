# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/mysql/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH=$JAVA_HOME/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/stark/.oh-my-zsh"
export TH="/Users/stark/airlab/repos/treehouse"
export ENV=development;

export CDPATH=.\
:${HOME}\
:${HOME}/airbnb-repos\
:${HOME}/airlab\
:${HOME}/airlab/repos\
:${HOME}/airlab/repos/treehouse\
:${HOME}/airlab/repos/treehouse/projects\
:${HOME}/airlab/repos/treehouse/projects/tns\
:${HOME}/airlab/repos/treehouse/projects/tns/kyoo\

eval "$(rbenv init -)"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"

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
COMPLETION_WAITING_DOTS="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

function splom {
  git pull origin master --rebase --autostash;
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


# AIRLAB-DO-NOT-MODIFY section:ShellWrapper {{{
# Airlab will only make edits inside these delimiters.

# Source Airlab's shell integration, if it exists.
if [ -e ~/.airlab/shellhelper.sh ]; then
  source ~/.airlab/shellhelper.sh
fi
# AIRLAB-DO-NOT-MODIFY section:ShellWrapper }}}

alias awk1="awk '{print \$1}'"
alias awk2="awk '{print \$2}'"
alias awk3="awk '{print \$3}'"
alias awklast="rev | awk1 | rev"

alias ..="cd .."      # if you’re not using “.” for sourcing bash

alias c=clear


source stark-scripts/airbnb_commands.zsh


export PATH=$PATH:$(go env GOPATH)/bin

