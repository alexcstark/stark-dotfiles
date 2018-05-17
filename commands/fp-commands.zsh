function fp-r {
  fp;
  if [ -z $1]
  then
    foreman start -f Procfile.dev rails=1,delayed=0,
  else
    foreman start -f Procfile.dev rails=1,delayed=1;
  fi
}

function fp-wp {
  fp;
  killall node;
  yarn webpack CoreApp;
}

function fp-window {
  osascript -e \
  'tell application "iTerm" to activate' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp-r 3"' -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "d" using {command down, shift down}' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp"' -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp-wp"' -e 'tell application "System Events" to tell process "iTerm" to key code 52';
}
