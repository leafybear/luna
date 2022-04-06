#:::::::::::::::::::::::::::::::::::::::::::
# Set the timezone
#

ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
timedatectl set-ntp true
