#!/usr/bin/env bash

install_mac() {
    echo "installing tools for macOS..."

    # install Homebrew if not already (http://brew.sh)
    which brew >/dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew update
    brew install neovim git tmux bash-completion sl curl jq

    # Install some fun ones
    brew install fzf bat fd ripgrep

    # Install CLIs
    brew install gh

    # Install GNU core utilities (better than MacOSX ones)
    brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent diffutils

    # GNU utilities are prefixed with a `g`. Add "gnubin" directory to path
    # to access these commands with their normal names.
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # access their man pages with normal names
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
}

ERROR_MSG="ERROR: not all dev tools were installed!"

if uname | grep -i darwin >/dev/null ; then
    install_mac || echo $ERROR_MSG
else
    echo "not on macOS!"
fi

