#:::::::::::::::::::::::::::::::::::::::::::
# Generate the FStab file
#

echo "genfstab -U -p $1 >> $1/etc/fstab"
genfstab -U -p $1 >> $1/etc/fstab
