#!/bin/bash

MACOS=false
DATE_TIMESTAMP=$(date +%Y-%m-%d)
IFS=

if [ "$(uname)" == "Darwin" ]; then
    MACOS=true
fi

get_input_df_true () {
    while true; do
        read -p $1 yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "Skipping"; break;;
            "" ) $2; break;;
            * ) echo "Please answer yes or no.";;
        esac
     done
}

get_input_df_false () {
    while true; do
        read -p $1 yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "Skipping"; break;;
            "" ) echo "Skipping"; break;;
            * ) echo "Please answer yes or no.";;
        esac
     done
}

install_font () {
    echo "Installing SF mono font"
    open $PWD/fonts/*
}

macos_capslock_keymap () {
    CAPS_KEY=0x700000039
    F10_KEY=0x700000043

    DATA=$(printf '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":%s,"HIDKeyboardModifierMappingDst":%s}]}' $CAPS_KEY $F10_KEY)
    hidutil property --set $DATA

    echo "Successfully overwrote CAPS KEY to F10!"
}

get_config_files() {
  CONFIG_FILES=$(find * -type f -path "**/*" ! -path ".*" ! -path "fonts/*")
}

move_config_files () {
  local CONFIG_FILES=0
  COUNT=0
  get_config_files

  while read file; do
    DIR=$( echo $file | cut -d/ -f 1 )
    FILE=$( echo $file | cut -d/ -f 2 )

    mkdir -p "$HOME/.config/$DIR"
    cp $file "$HOME/.config/$file"
    COUNT=$((COUNT + 1))
  done <<< $CONFIG_FILES

  printf "Moved %s config files!\n" $COUNT
}

# Promps for installing custom SF Mono font
# patched with devicons + more
get_input_df_false "Install custom font? (y/N) " install_font

# Prompt for re-mapping caps-lock for tmux
if [ $MACOS ]; then
   get_input_df_false "Add custom caps-lock to F10 keymap? (y/N) " macos_capslock_keymap
fi

# Get config files to copy info $HOME/.config
get_config_files

# Prompt copy config files to $HOME
get_input_df_true "Move config files to $HOME/.config? (Y/n) " move_config_files

