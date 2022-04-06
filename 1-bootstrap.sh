#:::::::::::::::::::::::::::::::::::::::::::
# Boostrap
# install a basic Arch system
#

if [ -d "$1" ]; then
	pacstrap -i $1 base base-devel arch-install-scripts reflector refind \ #
		linux linux-firmware dosfstools exfat-utils ntfs-3g \
		iwd openssh rsync wget curl git nmap \
		neovim nnn zsh tmux tree fd fzf exa neofetch gdu weechat \
		patch dstat pv htop multitail lftp mutt lm_sensors \
		gitui lazygit python-pip \
		terminus-font \
		avahi nss-mdns \
		ranger screen atool highlight libcaca lynx w3m mediainfo poppler transmission-cli \
		alsa-utils pulseaudio pavucontrol paprefs \
		ffmpeg imagemagick perl-exif-tools youtube-dl \
		xorg-server xorg-xinit xorg-xkill xorg-xev xorg-xsetroot xorg-xrdb xorg-xfontsel xscreensaver \
		bspwm sxhkd picom viu kitty feh sxiv scrot rofi rofimoji dunst mpv wireless_tools \
		blender krita gimp gpick firefox opera grafx2 lxappearance-gtk3

else
	echo -e "Missing a directory to pacstrap into."
	echo -e "Re-run:"
	echo -e "$\tamy-pacstrap.sh /path/to/sys"
fi
