#!/bin/sh
source ~/dotfiles/setup/functions.sh

if ! command -v brew >/dev/null; then
 fancy_echo "Installing Homebrew ..."
   curl -fsS \
     'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

   append_to_zshrc '# recommended by brew doctor'

   # shellcheck disable=SC2016
   append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1

   export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
 fancy_echo "Uninstalling old Homebrew-Cask ..."
 brew uninstall --force brew-cask
fi

brew update && brew install `brew outdated`

fancy_echo "Installing CLI tools"
brew install openssl
brew install zsh
brew install zsh-completions
brew install the_silver_searcher
brew install wget

fancy_echo "Installing python and setting up Neovim"
brew install python3
brew install neovim/neovim/neovim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim

brew install chrome-cli
brew install git
brew install rvm
brew install ruby-build
brew install imagemagick
brew install heroku

brew install postgresql
brew services start postgresql

brew tap caskroom/cask
brew cask install mongodb
brew cask install google-chrome
brew cask install iterm2
brew cask install skype
brew cask install postman

fancy_echo "Installing Misc Apps"
brew cask install slack
brew cask install spotify
brew cask install kindle

fancy_echo "Setting up Node with NVM"
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
source ~/dotfiles/setup/shell.sh
nvm install node
nvm alias default node

fancy_echo "Installing global npm packages"
npm install -g npm@latest
npm install -g npm-check-updates browser-sync
npm i -g js-beautify
npm i -g eslint
npm i -g webpack

fancy_echo "Installing Yarn"
brew install yarn
export PATH="$PATH:`yarn global bin`"
