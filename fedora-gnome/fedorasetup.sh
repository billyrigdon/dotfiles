#!/bin/bash

echo "Enter new hostname"
read newhostname

hostnamectl set-hostname $newhostname

currentuser=$(whoami)

sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 
 
sudo dnf install gnome-tweak-tool gnome-shell-extension-user-theme chromium icedtea-web java-latest-openjdk virt-manager snapd arc-theme numix-icon-theme-circle vim gnome-shell-extension-no-topleft-hot-corner gnome-shell-theme-flat-remix

sudo systemctl enable snapd
sudo systemctl start snapd

sleep 10

sudo ln -s /var/lib/snapd/snap /snap
sudo snap install code --classic
sudo snap install powershell --classic

mv ./.scripts ~/.scripts
echo "export PATH="/home/$currentuser/.scripts:$PATH"" >> ~/.bashrc

rm -r ~/.local/share/applications/*
rm -r ~/Public
rm -r ~/Templates
mkdir ~/Git
mv ./Wallpapers ~/Pictures/
