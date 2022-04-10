#:::::::::::::::::::::::::::::::::::::::::::
# Boostrap
# install a basic Arch system
#


echo "pacstrap -i $1 base base-devel arch-install-scripts reflector linux linux-firmware dosfstools exfat-utils ntfs-3g iwd openssh rsync wget curl git nmap terminus-font avahi nss-mdns"
pacstrap -i $1 \
	base base-devel arch-install-scripts reflector \
	linux linux-firmware dosfstools exfat-utils ntfs-3g \
	iwd openssh rsync wget curl git nmap terminus-font \
	avahi nss-mdns
