#!/bin/bash

sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 
 
sudo dnf install gnome-tweak-tool gnome-shell-extension-user-theme chromium icedtea-web java-latest-openjdk virt-manager snapd arc-theme numix-icon-theme-circlevim gnome-shell-extension-no-topleft-hot-corner

sudo systemctl enable snapd
sudo systemctl start snapd

sudo ln -s /var/lib/snapd/snap /snap
sudo snap install vscode --classic
sudo snap install powershell --classic

ssh-add ~/.ssh/id_rsa

s#udo cp -r ./lightmode /usr/bin/lightmode
#sudo cp -r ./darkmode /usr/bin/darkmode
#gsettings set org.gnome.desktop.interface gtk-theme Arc
#gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark

rm -r ~/Public
rm -r ~/Templates
mkdir ~/Git

