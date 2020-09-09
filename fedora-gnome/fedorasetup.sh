#!/bin/bash

#Set hostname
echo "Enter new hostname"
read newhostname
hostnamectl set-hostname $newhostname


#Install rpmfusion repos and install applications that I use
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install gnome-tweak-tool gnome-shell-extension-user-theme chromium icedtea-web java-latest-openjdk virt-manager snapd arc-theme numix-icon-theme-circle vim gnome-shell-extension-no-topleft-hot-corner gnome-shell-theme-flat-remix gnome-shell-extension-topicons-plus -y

#Configuration needed to install Docker in Fedora 32
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade
sudo firewall-cmd --reload
sudo dnf install moby-engine docker-compose
sudo systemctl enable docker

#Start/enable snapd, wait 10s for it to start, create symlink for classic mode, and install some snaps
sudo systemctl enable snapd
sudo systemctl start snapd
sleep 10
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install code --classic
sudo snap install powershell --classic

#Move scripts to .scripts directory and place explicit directory in $PATH
currentuser=$(whoami)
mv ./.scripts ~/.scripts
echo "export PATH="/home/$currentuser/.scripts:$PATH"" >> ~/.bashrc

#Remove unneeded home folders, create 'Git' and 'appimages' folders, and move wallpapers folder to ~/Pictures 
rm -r ~/Public
rm -r ~/Templates
mkdir ~/Git
mkdir ~/.appimages
mv ./Wallpapers ~/Pictures/

#Enable/Disable Gnome-extensions
gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable launch-new-instance@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable places-menu@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable nohotcorner@azuri.free.fr
gnome-extensions enable openweather-extension@jenslody.de
gnome-extensions enable TopIcons@phocean.net
gnome-extensions disable background-logo@fedorahosted.org

#Bring back minimize and maximize and set GTK theme
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
gsettings set org.gnome.desktop.interface gtk-theme Flat-Remix-GTK-Blue-Dark
gsettings set org.gnome.desktop.wm.preferences theme Flat-Remix-GTK-Blue-Dark
gsettings set org.gnome.shell.extensions.user-theme name Flat-Remix-Blue-Dark-fullPanel
gsettings set org.gnome.desktop.background picture-uri file:////home/billy/Pictures/Wallpapers/dark-wallpaper.png

#Lock down firewall
sudo firewall-cmd --permanent --zone=FedoraWorkstation --remove-port=1025-65535/udp
sudo firewall-cmd --permanent --zone=FedoraWorkstation --remove-port=1025-65535/tcp
sudo firewall-cmd --reload


