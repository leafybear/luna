#:::::::::::::::::::::::::::::::::::::::::::
# Set the hostname
#

if [ -d "$1" ]; then
	
	hostnamectl set-hostname $1
	hostnamectl set-icon-name computer
	hostnamectl set-chassis desktop

else
	echo -e "Give me a new hostname to set:"
	echo -e "$\t./setHostname.sh new-hostname"
fi
