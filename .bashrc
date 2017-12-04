#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi
shopt -s extglob
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend

# calculator
calc() {
    echo "scale=8;$@" | bc -l
}

# note taker

note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    elif [[ "$1" == "-e" ]]; then
        # edit
        $EDITOR "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

# cd into first arg and ls -A
cdl () {
    if [ -z "$1" ] ; then
        printf "Missing operand"
    else
        cd "$1"
        ls -A
    fi
}

# mkdir and cd into first arg
mkcd () {
    if [ -z "$1" ] ; then
        printf "Missing operand"
    else
        mkdir "$@"
        cd "$1"
    fi
}

# compile and run <file.c> with options after -o
gccc () {
    if [ -z "$1" ] ; then
        printf "Usage: gccc <inputcode.c> <outputfile>"
    else 
        gcc "$1" -o "${1%%.*}" && ./"${1%%.*}"
    fi
}

bldin () {
    cd ~/projects/void-packages
    ./xbps-src clean $* &&
    ./xbps-src -f pkg $* &&
    sudo xbps-install -ffi --repository=./hostdir/binpkgs $*
    cd -
}

### aliases ###

PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -A --color=auto'
alias cdv='cd ~/projects/void-packages'
alias cdd='cd ~/projects/dotfiles'
alias cds='cd ~/school'
alias cdc='cd ~/projects/a_book_on_c'
alias cdp='cd ~/projects'
alias cdf='cd ~/projects/foundations_final'
alias edd='vim ~/projects/void-packages/srcpkgs/dwm/files/config.h'
alias edb='vim ~/.bashrc'
alias edt='vim ~/.tmux.conf'
alias edv='vim ~/.vimrc'
alias bd='bldin dwm'
alias bs='bldin st'
alias nethack='ssh nethack@alt.org'
alias ta='tmux attach'
alias termbin="nc termbin.com 9999"

## School-related ##
alias sshpsu='ssh iwinter@linux.cs.pdx.edu'
