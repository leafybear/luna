#:::::::::::::::::::::::::::::::::::::::::::
# Set the hostname
#
#!/bin/sh

echo "hostnamectl set-hostname $1"
hostnamectl set-hostname $1
echo "hostnamectl set-icon-name computer"
hostnamectl set-icon-name computer
echo "hostnamectl set-chassis desktop"
hostnamectl set-chassis desktop
