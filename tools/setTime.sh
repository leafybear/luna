#:::::::::::::::::::::::::::::::::::::::::::
# Set the timezone
#

echo "ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime"
ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
echo "timedatectl set-ntp true"
timedatectl set-ntp true
