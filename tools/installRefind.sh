#:::::::::::::::::::::::::::::::::::::::::::
# Install rEFInd boot manager
#
#


echo "pacman -S refind"
pacman -S refind
echo "refind-install"
refind-install
