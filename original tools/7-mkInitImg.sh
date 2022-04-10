#:::::::::::::::::::::::::::::::::::::::::::
# Re-make the boot image to include our console font
#

cp configs/mkinitcpio.conf /etc/mkinitcpio.conf
mkinitcpio -p linux
