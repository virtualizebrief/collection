#!/bin/bash

echo Install DNF Flatpak upgrades
sudo dnf upgrade -y && flatpak upgrade -y
exit

EOF
