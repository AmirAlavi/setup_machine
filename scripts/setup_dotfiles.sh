#!/bin/bash

# Amir Alavi
# This script deletes any existing dotfiles (any template dotfiles
# shipped with the OS) and replaces them with symlinks to the
# appropriate file in this repo

# Just add any new dotfiles to this list
DOTFILES=".bashrc .emacs"
DIR=$(pwd)
DOTFILES_DIR=$DIR/../dotfiles

cd $HOME

for f in $DOTFILES;
do
    # If the file already exists in the home directory
    # then delete it and replace it with our symlink.
    # If it doesn't already exist, add a symlink to ours
    rm $f &> /dev/null
    ln -s $DOTFILES_DIR/$f $f
done
