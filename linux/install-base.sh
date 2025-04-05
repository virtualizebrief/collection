#!/bin/sh

# update
sudo dnf upgrade -y && flakpak upgrade -y
sudo hostnamectl set-hostname --static mypc

# hosts
echo '8.8.8.8  dns.google.com' | sudo tee -a /etc/hosts # add dns entries as needed

# repositories
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# flakpak
flatpak install flathub com.google.Chrome -y
flatpak install flathub com.microsoft.Edge -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.github.vikdevelop.photopea_app -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub io.github.shiftey.Desktop -y
flatpak install me.timschneeberger.jdsp4linux -y

# dnf
sudo dnf install v4l2loopback-kmod -y # needed for virtual camera
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1 -y
sudo dnf install steam -y

# manual
steam
curl -L https://raw.githubusercontent.com/dragoonDorise/EmuDeck/main/install.sh | bash

EOF
