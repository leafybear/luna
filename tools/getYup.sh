#!/bin/bash

# Clone YUP from AUR
# make the package install
# and cleanup afterward.

# don't try to run if root or in a chroot

echo "git clone https://aur.archlinux.org/yup.git"
git clone https://aur.archlinux.org/yup.git
echo "cd yup"
cd yup
echo "makepkg -si"
makepkg -si
echo "cd .."
cd ..
echo "rm -rf yup"
rm -rf yup
