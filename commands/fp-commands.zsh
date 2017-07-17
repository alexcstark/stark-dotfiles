function fp-r {
  fp;
  kill_port 3000;
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

function fp-db {
  echo "getting dev DB"
  bundle exec cap production dev_db:load include_test=true;
  echo "migrating test db"
  RAILS_ENV=test be rake db:migrate;
}

function fp-travis {
  current_branch=$(git branch | grep \* | cut -d ' ' -f2)
  gb -m "sandbox-$current_branch"
  sed -i -e 's/always/never/g' $(pwd)/.travis.yml
}

function fp-microdump {
  fp;
  echo "drop the current db"
  dropdb flexport_development;
  echo "create a new db"
  createdb flexport_development;
  bundle exec rake flexport:load_micro_dump;
  echo "dump graph ql schema"
  bundle exec rake js:dump_graphql_schema;
}

function fp-migrate {
  fp;
  bundle exec rake db:migrate;
  RAILS_ENV=test bundle exec rake db:migrate;
}

function fp-pre-test {
  fp;
  echo 'PARALLEL test'
  echo 'Dropping dbs...'
  RAILS_ENV=test bundle exec rake db:drop 2>&1 | tee ~/logs/paralleldb.log;
  echo 'Creating any missing databases...'
  RAILS_ENV=test bundle exec rake parallel:create 2>&1 | tee ~/logs/paralleldb.log;
  echo 'Running migrations....'
  RAILS_ENV=test bundle exec rake parallel:migrate 2>&1 | tee ~/logs/paralleldb.log;
}

function fp-test {
  fp;
  echo 'PARALLEL test'
  echo 'Dropping dbs...'
  RAILS_ENV=test bundle exec rake db:drop 2>&1 | tee ~/logs/paralleldb.log;
  echo 'Creating any missing databases...'
  RAILS_ENV=test bundle exec rake parallel:create 2>&1 | tee ~/logs/paralleldb.log;
  echo 'Running migrations....'
  RAILS_ENV=test bundle exec rake parallel:migrate 2>&1 | tee ~/logs/paralleldb.log;
  echo 'Running tests....'
  RAILS_ENV=test bundle exec rake parallel:spec 2>&1 | tee ~/logs/paralleldb.log;
}

function fp-fix {
  fp;
  if [-z $1]
  then
    script/flexport/lint.rb javascript —fix;
  else
    ./node_modules/.bin/eslint --quiet --ext .js --ext .jsx $1.jsx —fix;
  fi
}
function fp-reload-test {
  RAILS_ENV=test rake db:drop; RAILS_ENV=test rake db:create; RAILS_ENV=test rake db:migrate;
}
function fp-morning {
  # echo 'turn off bluetooth'
  # blue;
  echo 'kill ruby processes'
  kill_port 3000;
  echo 'kill node processes'
  pkill node;
  echo 'navigate to fp folder'
  fp;
  echo 'check out master'
  gco master;
  echo 'rebase from upstream'
  gplom;
  bundle;
  npm i;
  echo 'run the reset script'
  fp-reset;
}

function fp-reset {
  fp;
  script/flexport/resetdb.sh fresh;
}

function fp-deploy {
  fp;
  bundle exec cap production deploy;
}

function fp-window {
  osascript -e \
  'tell application "iTerm" to activate' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp-r 3"' -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "d" using {command down, shift down}' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp"' -e 'tell application "System Events" to tell process "iTerm" to key code 52' -e \
  'tell application "System Events" to tell process "iTerm" to keystroke "fp-wp"' -e 'tell application "System Events" to tell process "iTerm" to key code 52';
}
