# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
unsetopt autocd beep nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# development
DOCKER=~/.docker/bin
FLUTTER=~/development/flutter/bin
GO_PKG=~/go/bin
PERL=/usr/bin/vendor_perl
UTILS=~/development/utils/bin
ZIG=~/zig
ZEN=~/zen
PATH=$PATH:$DOCKER:$FLUTTER:$GO_PKG:$PERL:$UTILS:$ZIG:$ZEN

export NVM_DIR="$HOME/development/javascript/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable ghostty terminal integration
# Ghostty shell integration for Bash. This should be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# fuzzy find
source <(fzf --zsh)
fuzzy_cd () {
    
}
alias icd='cd "$(fzf --walker=dir,follow,hidden)"'

# edit text
alias vim='nvim'
alias dos2unix='sed -i "s/\r$//"'

# aesthetics
alias ls='lsd'
alias grep='grep --color=auto'
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.yaml)"
fastfetch
