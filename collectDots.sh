#!/usr/bin/env sh

# copy (select) current dotfiles to ./dots
# effectively "output" config for portability or inspection

function collect () {
	cp -L $1 "dots/$2"
}

# vim ~/.vimrc
vimFile=($(cat ~/.nix-profile/bin/vim))
vimrcLoc=$(echo ${vimFile[6]} | sed "s/'//g ") 
collect $vimrcLoc ".vimrc"

#hyprland hyprland.conf
collect ~/.config/hypr/hyprland.conf "hyprland.conf"
