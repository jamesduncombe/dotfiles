# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jd"

# Sys utils
alias m='less'
alias c='clear'
alias l='ls'
alias s='grep'
alias t='tail'
alias o='open'
alias h='history | grep '
alias pag='ag --pager=less'

# alias v='/usr/local/bin/vim'
alias v='/Applications/MacVim.app/Contents/MacOS/Vim'

alias r='osascript -e "tell application \"Google Chrome\" to tell the active tab of its first window" -e "reload" -e "end tell"'

# war() {
#   fswatch -m fsevents_monitor $1 | xargs -n1 osascript -e "tell application \"Google Chrome\" to tell the active tab of its first window" -e "reload" -e "end tell"
# }

alias sshot='convert "$HOME/Desktop/$(ls -t ~/Desktop/ | head -1)" -resize 50% -unsharp 1.5x1.2+1.0+0.10 -strip -format jpg ~/Desktop/screenshot.jpg'

isitup() {
  while ((1)); do
    STATUS=$(curl -sI $1 | head -1 | awk '{ if ($2 == "200") print "true"; else print "false"; }')
    echo $STATUS
    sleep 2
  done
}

checkssl() {
  openssl s_client -servername $1 -connect $1:$2 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d '=' -f 2
}

# Copy the current directory
ccd() {
  pwd | pbcopy
}

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


source ~/Dropbox/dotfiles/.docker-aliases

# Git

grl() {
  if [[ $(git rev-parse --abbrev-ref HEAD) == develop && -f version.txt ]]; then
    echo "On develop"
    echo Creating release for ${1}
    git checkout -b release/${1}
    echo ${1} > version.txt
    git add version.txt
    git commit -m "Version bump"
    git checkout master
    git merge --no-edit --no-ff release/${1}
    sleep 1
    git checkout develop
    git merge --no-edit --no-ff release/${1}
    git branch -d release/${1}
    echo "Done, make sure you push and tag that commit! ✨"
  else
    echo "Wrong branch, be on develop 😜"
  fi
}

# Amnesia

amn() {
  # URL="http://localhost"
  URL="https://amnesia.io"
  if [ $# -ge 1 -a ! -f $1 ]; then
    input=$(cat -)
    temp=$(mktemp)
    echo $input > $temp
    # cat -t - > $temp
    curl -sF "file=@$temp;filename=xyz.$1" ${URL}
    rm $temp
  elif [ $# -ge 1 -a -f $1 ]; then
    curl -sF "file=@$1" ${URL}
  else
    echo "No filename provided (amn [filename])"
    echo "Try:"
    echo "amn [filename]"
    echo "or"
    echo "pbpaste | amn [filetype]"
    echo "More info: ${URL}"
    return 1
  fi
}

# Shortcuts to directories
alias sts="cd ~/Sites"

# SSH
alias sshc="vi ~/.ssh/config"

# RVM
alias rgl='rvm gemset list'
alias rl='rvm list'

# Bundler
alias bi='bundle install'
alias bx='bundle exec'

# Git
alias g='git'
alias gm='git merge'
alias gb='git branch'
alias gp='git push'
alias gc='git commit'
alias gl='git pull'
alias ga='git add'
alias gd='git diff'
alias gst='git status'
alias grm='git rm'
alias gll='git lg'
alias gsss='git show'
alias gsh='git stash'
alias gsl='git stash list'
alias gch='nocorrect git checkout'

alias gdno='git diff --name-only'
alias gdss='git diff --shortstat'
alias gds='git diff --staged'

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

# Octave
alias oc="octave-cli -q"

muc() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

# Pull in env vars from .env file
slurp() {
 if [[ -f .env ]]; then
    echo "### Setting up environment variables from .env"
    $vars_to_export=$(grep '^[A-Z]' .env | xargs)
    export $vars_to_export
    echo $vars_to_export
    # cat .env | grep -v '#' | while read line; do
    #   echo $line
    #   export $line
    # done
  fi
}

roc() {
  fswatch -m fsevents_monitor $1 | xargs -n1 -I{} $2 $(basename {})
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
 plugins=()

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/X11/bin:$HOME/Dropbox/bin:/usr/local/go/bin

# export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

# Adding NPM modules
export PATH=$PATH:/usr/local/lib/node_modules

# Adding GOPATH
export GOPATH=$HOME/Dropbox/Go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


# added by travis gem
# [ -f /Users/james/.travis/travis.sh ] && source /Users/james/.travis/travis.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Python virtualenv
#export PYENV_ROOT=/usr/local/var/pyenv
#export PATH=~/.pyenv/shims:$PATH
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="/usr/local/opt/qt/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
