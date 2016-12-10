#!/bin/bash

# Amir Alavi
# This script does everything necessary to set up
# a fresh machine just the way I like it
REMOTE_REPO_DIR=$HOME/custom_remotes
echo "Running setup_machine..."
DIR=$(pwd)
cd $DIR/scripts/
/bin/bash install_software.sh
/bin/bash setup_dotfiles.sh
if [ -d $REMOTE_REPO_DIR ]
then
    rm -rf $REMOTE_REPO_DIR
fi
git clone https://github.com/AmirAlavi/amirs_remote_machines.git $REMOTE_REPO_DIR
cd $REMOTE_REPO_DIR
./configure_ssh.sh
