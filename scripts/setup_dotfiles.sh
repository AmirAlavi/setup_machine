#!/bin/bash

# Amir Alavi
# This script deletes any existing dotfiles (any template dotfiles
# shipped with the OS) and replaces them with symlinks to the
# appropriate file in this repo

# Just add any new dotfiles to this list
DOTFILES=.[^.]*
DIR=$(pwd)
DOTFILES_DIR=$DIR/../dotfiles

cd $DOTFILES_DIR

for f in $DOTFILES;
do
    cd $HOME
    # If the file already exists in the home directory and it is not already
    # a symbolic link, then it must be the original dotfile, so we should back
    # it up as a ".original" file.
    # Otherwise, if the file exists as a symbolic link, delete it
    # then add a symlink to our version of the dotfile.
    if [ -a $f ]
    then
	if [ ! -h $f ]
	then
	    mv $f $f.original
	else
	    rm $f
	fi
    fi
    ln -s $DOTFILES_DIR/$f $f
done
