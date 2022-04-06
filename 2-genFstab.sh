#:::::::::::::::::::::::::::::::::::::::::::
# Generate the FStab file
#

genfstab -U -p $1 >> $1/etc/fstab
