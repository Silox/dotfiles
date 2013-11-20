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
export TMUX_POWERLINE_SEG_WEATHER_LOCATION="970013"

autoload colors
colors

setopt prompt_subst
PROMPT='[%T]%{$fg[red]%} %n@%m %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%} %(?.✔.✗) '
export PATH="/home/tnaessens/.cabal/bin:.:/usr/local/bin/:/usr/local/sbin/:/home/tnaessens/android-sdks/platform-tools/:$PATH"
export PATH=/home/tnaessens/.gem/bin:$PATH
export PATH=/home/tnaessens/android-sdks/tools:$PATH
export PATH=/home/tnaessens/Programs/gradle-1.7/bin:$PATH
export PATH=/home/tnaessens/Programs/pin-2.13-61206-gcc.4.4.7-linux:$PATH
export ANDROID_HOME=~/android-sdks/
export EDITOR=vim
export GEM_HOME=$HOME/.gem
export MODULEPATH=$HOME/.local/easybuild/modules/all

alias tmux="tmux -2"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# Mac specific thingies
platform=$(uname -a)
if [[ $platform =~ "Darwin" ]]; then
  eval "$(rbenv init -)"
  alias vim='mvim -v'
#  export CLICOLOR=1
else
  alias ls="ls --color=auto"
  eval $(dircolors)
fi

#if [[ "$TERM" != "screen-256color" ]]; then
#  tmux
#  exit
#fi

