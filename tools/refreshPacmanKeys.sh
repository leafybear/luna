#:::::::::::::::::::::::::::::::::::::::::::
# Refresh Pacman GPG Keys
#
#

echo "pacman-key --init"
pacman-key --init
echo "pacman-key --populate archlinux"
pacman-key --populate archlinux
echo "pacman -S archlinux-keyring"
pacman -S archlinux-keyring
echo "pacman -Scc"
pacman -Scc
echo "pacman -Syu"
pacman -Syu
