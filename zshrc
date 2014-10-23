# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

autoload colors
colors

# ls colors
alias ls='ls -G'

setopt prompt_subst
PROMPT='[%T]%{$fg[red]%} %n@%m %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} %(?.✔.✗) '
export EDITOR=vim

alias wow="hub status"

alias mysqlstart='sudo /usr/local/mysql/support-files/mysql.server start'
alias mysqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'

# OSX
## Same pwd on tab
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=/usr/local/bin:$PATH
export PATH=/Applications/Android\ Studio.app/sdk/tools:$PATH
export PATH=/Applications/Android\ Studio.app/sdk/platform-tools:$PATH

# added by travis gem
[ -f /Users/silox/.travis/travis.sh ] && source /Users/silox/.travis/travis.sh
