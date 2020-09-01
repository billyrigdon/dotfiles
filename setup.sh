#!/bin/bash

sudo mv ./i3blocks /usr/share/i3blocks
sudo mv /usr/share/zsh/manjaro-zsh-prompt /usr/share/zsh/manjaro-zsh-prompt.old
sudo mv ./manjaro-zsh-prompt /usr/share/zsh/manjaro-zsh-prompt

mv ~/.config ~/.config.old
mv ./.config ~/.config

sudo pacman -S icedtea-web feh pavucontrol redshift chromium i3blocks terminator ranger xfce4-power-manager  ttf-roboto ttf-roboto-mono virt-manager lxappearance thunar

yay -S networkmanager-dmenu-git pfetch gruvbox-dark-gtk
