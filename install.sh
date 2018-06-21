#!/bin/bash
set -eu

REPO=$HOME/dotfiles.tim_goodwin

echo "Installing dev tools"
# $REPO/install_tools.sh

if uname | grep -i darwin >/dev/null ; then
    echo "Mac OS X detected. Symlinking $HOME/.profile => $REPO/dotfiles/profile"
    rm -f $HOME/.profile
    ln -s $REPO/dotfiles/profile $HOME/.profile
elif uname | grep -i linux >/dev/null ; then
    append_str='[[ -n $LC_tim_goodwin ]] && source $HOME/dotfiles.tim_goodwin/dotfiles/bashrc || source $HOME/.bashrc'
    if ! grep -F "$append_str" $HOME/.bash_profile >/dev/null ; then
        echo "Linux detected. Appending magic to $HOME/.bash_profile..."
        echo $append_str >>$HOME/.bash_profile
    fi
fi

