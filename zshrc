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
export EDITOR=nvim

alias wow="hub status"
alias vim="nvim"

# OSX
## Same pwd on tab
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=$PATH:$(ruby -e 'print Gem.user_dir')/bin:/usr/local/bin

# rbenv
eval "$(rbenv init -)"

# pyenv
export PATH="/Users/silox/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
