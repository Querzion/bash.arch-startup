#!/bin/bash

# This script downloads a fresh empty suckless dwm session if you so want
# but it also extends to adding patches (which can be changed) and my personal
# config.def.h file and possible other files.

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

############################### SETTINGS
USER="$(whoami)"
APP="dwm"
DESCRIPTON="(Dynamic Window Manager)"
FROM_HERE="https://git.suckless.org/$APP"


################################################################### FILE & FOLDER PATHS
############ FILE & FOLDER PATHS

# Script Locations
FOLDER="bash.dwm-arch.startup"  # If 'bash.dwm-arch.startup' is renamed in any way.
LOCATION="$HOME/$FOLDER/files"

# Patch Script Location
PATCH="$LOCATION/scripts/patch/dwm-querzion/install.$APP.patches.sh"

# Configuration Files (Edited config.def.h)
CONFIG="$LOCATION/settings/.config/$APP/config.def.h"

# Installation Path
TO_THERE="$HOME/.config/wm/$USER/$APP"

################################################################### BACKUP SETTINGS
############ BACKUP SETTINGS

# Source folder
SOURCE_FOLDER="$HOME/.config/wm/$USER/$APP"

# Destination folder
DEST_FOLDER="$HOME/.config/vm"

# Create a timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Zip file name with timestamp
ZIP_FILENAME="$DEST_FOLDER/$USER/$APP-$USER.$TIMESTAMP.zip"


################################################################### DWM INSTALL
############ DWM INSTALL

echo -e "${YELLOW} Creating folder for $APP $DESCRIPTON installation... ${NC}"
# Create folder structure
mkdir -p $HOME/.config/wm
mkdir -p $HOME/.config/wm/$USER

echo -e "${PURPLE} Creating a backup of the prior $APP $DESCRIPTON installation... ${NC}"

# Zip command
zip -r "$ZIP_FILENAME" "$SOURCE_FOLDER"

# Check if the zip command was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Folder '$SOURCE_FOLDER' successfully zipped into '$ZIP_FILENAME'.${NC}"

    # Delete source folder
    rm -rf "$SOURCE_FOLDER"
    echo -e "${GREEN}Source folder '$SOURCE_FOLDER' deleted.${NC}"
else
    echo -e "${RED}Error: Failed to zip the folder.${NC}"
    exit 1
fi

echo -e "${YELLOW} Getting new $APP $DESCRIPTON source files... ${NC}"

# Install application
git clone $FROM_HERE $TO_THERE && cd $TO_THERE

echo -e "${YELLOW} Compiling $APP $DESCRIPTON... ${NC}"
sudo make clean install

echo -e "${GREEN} $APP installed successfully. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read


################################################################### DWM CONFIGURATION
############ DWM CONFIGURATION

echo -e "${PURPLE} Configuring config.def.h file. ${NC}"
echo "Making a backup."
# Copy to replace config.def.h
sudo mv $TO_THERE/config.def.h $TO_THERE/config.def.h.bak
echo "Copying a new."
sudo cp $CONFIG $TO_THERE

cd $DIR/$USER/dwm

sudo rm config.h
sudo make clean install

echo -e "${GREEN} $APP is now reconfigured. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read

################################################################### DWM PATCHING
############ DWM PATCHING


echo -e "${PURPLE} Patching $APP. ${NC}"

# Start Patch Install Script
sh $P

echo -e "${GREEN} $APP is now patched. ${NC}"

# Pause the script
#echo -e "${GREEN} PRESS ENTER TO CONTINUE. ${NC}"
#read