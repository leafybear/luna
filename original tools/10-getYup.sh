#!/bin/bash

# Clone YUP from AUR
# make the package install
# and cleanup afterward.

# don't try to run if root or in a chroot

git clone https://aur.archlinux.org/yup.git
cd yup
makepkg -si
cd ..
rm -rf yup
