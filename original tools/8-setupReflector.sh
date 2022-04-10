#:::::::::::::::::::::::::::::::::::::::::::
# Setup pacman mirror selection service
#

cp configs/reflector.conf /etc/xdg/reflector/reflector.conf
systemctl enable reflector
