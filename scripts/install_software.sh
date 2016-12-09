#!/bin/bash

# Amir Alavi
# This script will install all software that I need for
# development
echo "Running install_software..."
DIR=$(pwd)/../warez_lists
DOTFILES=$(pwd)/../dotfiles

# Detect platform and set package manager accordingly
# (must be either Ubuntu or OSX)
cat /etc/os-release | grep -i "ubuntu" &> /dev/null
if [ $? -eq 0 ]; then
    # Ubuntu detected
    echo "Ubuntu detected."
    PACKAGE_MANAGER_INSTALL="sudo apt-get install -y"
    DEV="$DIR/ubuntu/dev.list"
    LANG="$DIR/ubuntu/languages.list"
    ADMIN="$DIR/ubuntu/admin.list"
fi

uname -a | grep -i "darwin"
if [ $? -eq 0 ]; then
    # OS X detected
    echo "macOS detected."
    # Install Homebrew if not installed
    which brew
    if [ $? -ne 0 ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    PACKAGE_MANAGER_INSTALL="brew install"
    DEV="$DIR/mac/dev.list"
    ADMIN="$DIR/mac/admin.list"
fi

# Install first-party software (installs through package manager)
echo "Installing first-party software..."
WAREZ_LISTS="$DEV $LANG $ADMIN"
for list in $WAREZ_LISTS;
do
    $PACKAGE_MANAGER_INSTALL $(cat $list)
done

# Install third-party software and add-ons
# (install by means other than package managers)
# (some of these require git, which should have been
# installed from above)
echo "Installing third-party software..."
# emacs packages
# neotree
cd $HOME
if [ ! -d "neotree" ]; then
    git clone https://github.com/jaypei/emacs-neotree.git neotree
    NEO_PATH=$(pwd)/neotree
    echo "(add-to-list 'load-path \"$NEO_PATH\")" | cat - $DOTFILES/.emacs > $DOTFILES/temp && mv $DOTFILES/temp $DOTFILES/.emacs
fi
