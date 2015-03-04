# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jd"

# Sys utils
alias m='more'
alias c='clear'
alias l='ls'
alias s='grep -R'
alias t='tail'
alias o='open'
alias h='history | grep '

alias v='/Applications/MacVim.app/Contents/MacOS/Vim'

alias sb='subl'

# Networking
alias p='ping'

# Photoshop
alias psh='open -a "Adobe Photoshop CC"'

# Tmux
alias tm='tmux'
alias tls='tmux list-sessions'
alias ta='tmux attach-session -t'

# Vagrant
alias va='vagrant'
alias vssh='vagrant ssh'
alias vup='vagrant up'
alias vht='vagrant halt'

# RSpec
alias rsp='rspec'

# Mocha
alias mocha='nocorrect mocha'
alias mcc='mocha --compilers coffee:coffee-script'

# Forman start
fs() {
  if [[ -f Procfile.dev ]]; then
    foreman start -f Procfile.dev
  else
    foreman start
  fi
}

# Start rails - if there's a Procfile use it, else use rails s
startrails() {
  if [[ (-f Procfile.dev || -f Procfile) ]]; then
    fs
  else
    rails s
  fi
}

# In / out of directory
ino() {
  cd ..
  cd -
}

# Rails muxing

rmux() {
  SESH=$(basename `pwd`)

  tmux new-session -d -s $SESH
  tmux send-keys 'vi -c +Ex' 'C-m'
  tmux selectp -t 0

  tmux splitw -h -p 50
  tmux send-keys 'startrails' 'C-m'
  tmux selectp -t 1

  tmux splitw -v -p 50
  tmux send-keys 'tail -f ./log/development.log' 'C-m'
  tmux selectp -t 0
  tmux -2 attach-session -t $SESH
}

# Shortcuts to directories
alias sts="cd ~/Sites"

# SSH
alias sshc="vi ~/.ssh/config"

# Heroku
alias hr='heroku'

# RVM
alias rgl='rvm gemset list'
alias rl='rvm list'

# Bundler
alias bi='bundle install'
alias bx='bundle exec'

# Git
alias grm='git rm'
alias gll='git lg'
alias gsh='git stash'
alias gsl='git stash list'
alias gch='nocorrect git checkout'

alias gdno='git diff --name-only'
alias gdss='git diff --shortstat'

# Brew
alias bru='brew update'
alias bri='brew install'
alias brs='brew search'

# Go
alias go64linux='GOARCH=amd64 GOOS=linux go build'

# Gems
alias gml='gem list'

# Rails
alias pry="nocorrect pry"

muc() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

vers() {
  echo Database Versions:
  echo Heroku version: `heroku run rake db:version | grep Current | cut -d ' ' -f3`
  echo Local version: `rake db:version | grep Current | cut -d ' ' -f3`
}

# Pull in env vars from .env file
slurp() {
 if [[ -f .env ]]; then
    echo "### Setting up environment variables from .env"
    cat .env | grep -v '#' | while read line; do
      echo $line
      export $line
    done
  fi
}

# May move this out somewhere better
export RSPEC_RESULT_FILE=~/.last_rspec_result

syo() {
  RESULT=$(spec $1 2>/dev/null)
  echo $(echo $RESULT | tail -n 1) > $RSPEC_RESULT_FILE
  echo $(echo $RESULT | grep Finished) >> $RSPEC_RESULT_FILE
  echo $1 >> $RSPEC_RESULT_FILE
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails ruby rake)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export PATH=$PATH:/Applications/Postgres93.app/Contents/MacOS/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/sbin:/usr/X11/bin:$HOME/Dropbox/bin:/usr/local/go/bin

export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

# Adding NPM modules
export PATH=$PATH:/usr/local/lib/node_modules

export PATH=/usr/local/bin:$PATH

# Adding GOPATH
export GOPATH=$HOME/Dropbox/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# added by travis gem
[ -f /Users/james/.travis/travis.sh ] && source /Users/james/.travis/travis.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

