#:::::::::::::::::::::::::::::::::::::::::::
# Re-make the boot image to include our console font
#
#!/bin/sh

echo "cp configs/mkinitcpio.conf /etc/mkinitcpio.conf"
cp configs/mkinitcpio.conf /etc/mkinitcpio.conf
echo "mkinitcpio -p linux"
mkinitcpio -p linux
