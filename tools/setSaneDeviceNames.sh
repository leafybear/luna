#:::::::::::::::::::::::::::::::::::::::::::
# Change rules for new device names to be shorter (eth0 etc)
#

echo "ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules"
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
