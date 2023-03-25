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
     echo ""
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
     echo ""
}

install_font () {
    echo "Installing SF mono font"
    open $PWD/fonts/*
}

macos_capslock_shortcut() {
    cp scripts/tbind.sh /usr/local/bin/tbind
    chmod +x /usr/local/bin/tbind
    echo "Created tmux capslock keymap command as tbind"
}

macos_capslock_keymap () {
    macos_capslock_shortcut
    tbind
}

get_config_files() {
  CONFIG_FILES=$(find * -type f -path "**/*" ! -path ".*" ! -path "fonts/*" ! -path "scripts/*")
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

move_profile_file () {
  cp .profile $HOME

  echo "Moved .profile file!"
}

install_packages_brew () {
    declare -a packages=("cmake" "tree" "wget" "jq" "ripgrep" "watch" "tmux" "fish" "gh")
    echo "Installing ${#packages[@]} packages from brew"

    brew install --quiet "${packages[@]}"
}

configure_fish () {
    brew install --quiet fish

    # oh-my-fish does not exist
    if [ ! -d "$HOME/.local/share/omf" ]; then
        curl -s "https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install" > install

        fish install --noninteractive
        rm install
    else
        printf "oh-my-fish already configured!\n\n"
    fi

    echo ""
}

# Promps for installing custom SF Mono font
# patched with devicons + more
get_input_df_false "Install custom font? (y/N) " install_font

# Prompt for re-mapping caps-lock for tmux
if [ $MACOS ]; then
   get_input_df_false "Add custom caps-lock to F10 keymap? (y/N) " macos_capslock_keymap
fi

get_input_df_true "Add .profile file? (Y/n) " move_profile_file

# Installed common packages from brew
get_input_df_true "Install brew packages? (Y/n) " install_packages_brew

echo "Configurating fish shell"
configure_fish

# Get config files to copy info $HOME/.config
get_config_files

# Prompt copy config files to $HOME
get_input_df_true "Move config files to $HOME/.config? (Y/n) " move_config_files



