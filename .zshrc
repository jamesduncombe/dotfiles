# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="simple"

alias mocha='nocorrect mocha ' 

alias mcc='mocha --compilers coffee:coffee-script'

alias m='more'
alias c='clear'
alias l='ls'
alias s='grep -R'
alias t='tail'
alias sb='subl'

# Tmux
alias tls='tmux list-sessions'
alias ta='tmux attach-session -t'

# RSpec
alias rsp='rspec'

# Forman start
fs() {
  if [[ -f Procfile.dev ]]; then
    foreman start -f Procfile.dev
  else
    foreman start
  fi
}

# In / out of directory
ino() {
  cd ..
  cd -
}


# Shortcuts to directories
alias sts="cd ~/Sites"

# SSH
alias sshc="vi ~/.ssh/config"

# Heroku
alias h='heroku'

# RVM
alias rgl='rvm gemset list'
alias rl='rvm list'

# Bundler
alias bi='bundle install'

# Git
alias grm='git rm'
alias gll='git lg'
alias gsh='git stash'
alias gch='nocorrect git checkout'

alias gdno='git diff --name-only'
alias gdss='git diff --shortstat'

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=/Users/james/.rvm/gems/ruby-1.9.3-p125/bin

export PATH=$PATH:/Applications/Postgres93.app/Contents/MacOS/bin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/sbin:/usr/X11/bin:$HOME/Dropbox/bin:/usr/local/go/bin

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH=$PATH:/usr/local/heroku/bin

# Adding GOPATH
export GOPATH=$HOME/Dropbox/go
export PATH=$PATH:$GOPATH/bin

# added by travis gem
[ -f /Users/james/.travis/travis.sh ] && source /Users/james/.travis/travis.sh
