#
# ~/.bashrc
#

# path config
DOCKER=~/.docker/bin
GO_PKG=~/go/bin
ZIG=~/zig
ZEN=~/zen
PATH=$PATH:$DOCKER:$GO_PKG:$ZIG:$ZEN

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
