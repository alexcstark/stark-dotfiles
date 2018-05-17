function cd {
 builtin cd "$@";
 ls -a;
 autoenv_init;
}

function rc {
  be rails c;
}

function clp {
  cd ~/code-local/projects/$1;
}

function jn {
  jupyter notebook;
}

function src {
  spring rails c;
}

function py {
  python "$@";
}

function dkc_restart {
  dkrm;
  dkrmi;
  dkc up;
}

function kill_port {
  kill -9 $(lsof -t -i:$1)
}

function venv {
  version="$1"
  echo "Creating virtual environment: env ${version}"
  echo "Removing existing installations"
  rm -rf env;
  rm .env;
  pyenv virtualenv "${version}" --no-site-packages env;
  touch .env;
  echo "source env/bin/activate" >> .env;
  reprof;
}

function gplom {
  git pull origin master --rebase;
}

function grws {
  git diff -w --no-color | git apply --cached --ignore-whitespace && git checkout -- . && git reset && git add -p;
}

function be {
  bundle exec $@;
}

function dkrmi {
 docker rmi $(docker images --filter "dangling=true" -q --no-trunc);
}

function dkconnect {
 docker exec -it $1 bash;
}
# dkc dev.yml; dkc prod.yml
function dkcup {
 docker-compose -f $1 up;
}

function dkc {
 docker-compose $@;
}

function dki {
 docker images;
}
function dkrm {
 docker rm -f `docker ps -aq`;
}
function dk {
 docker $@;
}

function findall {
  find . -name $1;
}
function pgshowdbs {
  psql -l;
}

function showports {
  lsof -Pi | grep LISTEN;
}

function gs {
  git status $@;
}

function prof {
  case "$1" in
    commands) vim $DF/commands/commands.zsh;;
    shortcuts) vim $DF/shortcuts.zsh;;
    syntax) code ~/.vscode/extensions/theme-jarvblue/themes/JarvBlue\ \(5\).tmTheme/;;
    fp) vim $DF/commands/fp-commands.zsh;;
    loc) cd $DF;;
    *) vim ~/.zshrc;;
  esac
}

function reprof {
 source ~/.zshrc;
}

function gpob {
  current_branch = $(git branch | grep \* | cut -d ' ' -f2)
  if [[ $current_branch != "master" ]] then
    case "$1" in
      -f) git push -f origin `git rev-parse --abbrev-ref HEAD`;;
      *) git push origin `git rev-parse --abbrev-ref HEAD`;;
    esac
  else
    echo "NEVER PUSH TO MASTER"
  fi
}

function gplob {
  git pull origin `git rev-parse --abbrev-ref HEAD` --rebase;
}


function pgkill {
  kill -INT `head -1 /usr/local/var/postgres/postmaster.pid`;
}

function awsssh {
  ssh -v -i ~/.ssh/alexcstark.pem ec2-user@$1;
}

function chrome {
  open -a "Google Chrome" $1;
}

function gc {
  git commit $1 $2;
}

function pgstart {
  postgres -D /usr/local/var/postgres;
}

function gpum {
  git pull upstream master --rebase;
}

function gpogig {
  confirm && git push origin master & git push --mirror bitbucket;
}

function gphm {
 git push heroku master;
}

function gpo {
  git push origin $1;
}

function confirm {
    # call with a prompt string or use a default
    read "response?Are you sure? [y/N] "
    if [[ "$response" =~ ^[Yy]$ ]]
    then
      echo 'moving along...'
      true
    else
      echo 'cancelling...'
      false
    fi
}

function blue {
  echo "toggling bluetooth"
  osascript <<EOF
  tell application "System Events"

      tell process "System Preferences"
          activate
      end tell

      tell application "System Preferences"
          set current pane to pane "com.apple.preferences.Bluetooth"
      end tell

      tell process "System Preferences"

          set statName to name of button 3 of window 1 as string
          set failSafe to 0

          repeat until statName is not name of button 3 of window 1 as string ¬
              or failSafe is 10
              click button 3 of window 1
              set failSafe to failSafe + 1
              delay 0.1
          end repeat

      end tell

      tell application "System Preferences"
          quit
      end tell

  end tell
EOF
echo "bluetooth!"

}


function py-window {
  osascript -e \
  'tell application "iTerm" to activate' -e \
  "tell application \"System Events\" to tell process \"iTerm\" to keystroke \"cd $(pwd)\"" -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  "tell application \"System Events\" to tell process \"iTerm\" to keystroke \"flask run\"" -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "d" using {command down, shift down}' -e \
  "tell application \"System Events\" to tell process \"iTerm\" to keystroke \"cd $(pwd)\"" -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  "tell application \"System Events\" to tell process \"iTerm\" to keystroke \"npm run dev\"" -e 'tell application "System Events" to tell process "iTerm" to key code 52';
}

function new-jarv-blue {
  yo code && rm -rf ~/.vscode/extensions/theme-jarvblue && mv theme-jarvblue ~/.vscode/extensions;
}

function gkc {
  geeknote create --title $@;
}

function gkf {
  geeknote find --search $@;
}

function gke {
  geeknote edit --note $@;
}

function gks {
  geeknote show $@;
}

function gkr {
  geeknote remove --note $@;
}

function gknl {
  geeknote notebook-list $@;
}

