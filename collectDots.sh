#!/usr/bin/env sh

# copy (select) current dotfiles to ./dots
# effectively "output" config for portability or inspection

function collect () {
	cp -L -f $1 "dots/$(hostname)/$2"
}

# vim ~/.vimrc
vimFile=($(cat ~/.nix-profile/bin/vim))
vimrcLoc=$(echo ${vimFile[6]} | sed "s/'//g") 
collect $vimrcLoc ".vimrc"

# neovim init.lua & .vim file
collect ~/.config/nvim/init.lua "neovim/init.lua"
initLua=($(cat ~/.config/nvim/init.lua))
vimLoc=$(echo ${initLua[2]} | sed "s/]//g")
collect $vimLoc "neovim/init.vim"

# hyprland hyprland.conf
collect ~/.config/hypr/hyprland.conf "hyprland.conf"

# waybar config and style.css
collect ~/.config/waybar/config "waybar/config"
collect ~/.config/waybar/style.css "waybar/style.css"

# tmux
collect ~/.config/tmux/tmux.conf "tmux.conf"

# git config
collect ~/.config/git/config ".gitconfig"

# kitty
collect ~/.config/kitty/kitty.conf "kitty.conf"
