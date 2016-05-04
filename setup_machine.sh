#!/bin/bash

# Amir Alavi
# This script does everything necessary to set up
# a fresh machine just the way I like it

DIR=$(pwd)
cd $DIR/scripts/
/bin/bash install_software.sh
/bin/bash setup_dotfiles.sh
