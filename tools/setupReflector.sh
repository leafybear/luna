#:::::::::::::::::::::::::::::::::::::::::::
# Setup pacman mirror selection service
#

echo "cp configs/reflector.conf /etc/xdg/reflector/reflector.conf"
cp configs/reflector.conf /etc/xdg/reflector/reflector.conf
echo "systemctl enable reflector"
systemctl enable reflector
