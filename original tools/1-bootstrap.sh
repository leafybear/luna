#:::::::::::::::::::::::::::::::::::::::::::
# Boostrap
# install a basic Arch system
#

if [ -d "$1" ]; then
	# pacstrap -i $1 \
	# 	base base-devel arch-install-scripts reflector \
	# 	linux linux-firmware dosfstools exfat-utils ntfs-3g \
	# 	iwd openssh rsync wget curl git nmap terminus-font \
	# 	avahi nss-mdns

else
	echo -e "Missing a directory to pacstrap into."
	echo -e "Re-run:"
	echo -e "$(basename $0) /path/to/sys"
fi
