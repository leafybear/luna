# :::::::::::::::::::::::::::::::::::::::::::
#  Luna, the Arch Linux Install Configurator

#  A. Bentley (leafybear@icloud.com)
#  edit: 2022
# :. : . : . : . : . : . : . : . : . : . : .:
#!/bin/bash




# :. : . : . : . : . : . : . : . : . : . : .:
# : .  formatting  . :



logo () {
	echo "    __                    "
	echo "   / / _   _ _ __   __ _  "
	echo "  / / | | | | '_ \ / _\` | "
	echo " / /__| |_| | | | | (_| | "
	echo " \____/\__,_|_| |_|\__,_| "
	echo " an Arch Linux configuration tool"
	echo
}

err () { # display an error message to stderr (in red)
	printf "\033[1;31m%s\033[0m\n" "$*" >&2
}

inform () { # display an informational message (first argument in green, second in magenta)
	printf "\033[0;32m%s \033[0;35m%s\033[0m\n" "$1" "$2"
}

prompt () { # prompts the user with message in $1-2 ($1 in blue, $2 in magenta) and saves the input to the variables in $REPLY and $REPLY2
	printf "\033[0;34m%s\033[0;35m%s\033[1;34m: \033[0m" "$1" "$2"
	read -r REPLY REPLY2
}

warn () { # display an informational message (first argument in green, second in magenta)
	printf "\033[0;31m%s \033[0;33m%s\033[0m\n" "$1" "$2"
}

menu_line_even () { # displays an even (cyan) line of a menu line with $2 as an indicator in [] and $1 as the option
	printf "\033[0;34m[\033[0;36m%s\033[1;34m] \033[0;36m%s\033[0m\n" "$2" "$1"
}

menu_line_odd() { # displays an odd (yellow) line of a menu line with $2 as an indicator in [] and $1 as the option
	printf "\033[0;34m[\033[0;33m%s\033[1;34m] \033[0;33m%s\033[0m\n" "$2" "$1"
}

menu_line_strong() {
	# displays a warning (red) line of a menu line with $2 as an indicator in [] and $1 as the option
	printf "\033[0;34m[\033[0;35m%s\033[0;34m] \033[0;35m%s\033[0m\n" "$2" "$1"
}

menu_line_alternate() {
	menu_line_parity=${menu_line_parity:-0}
	if [ "$menu_line_parity" -eq 0 ]; then
		menu_line_odd "$1" "$2"
		menu_line_parity=1
	else
		menu_line_even "$1" "$2"
		menu_line_parity=0
	fi
}





# :. : . : . : . : . : . : . : . : . : . : .:
# : .  input menus  . :


usage() { warn "Usage:" "$(basename $0) /path/to/system/root"; exit; }

qq () {
	echo
	echo "bye"
	sleep 0.1
	exit
}

top_menu () {
	inform "What shall we do?"
	sleep 0.5
	menu_line_alternate "install packages" "i"
	sleep 0.025
	menu_line_alternate "system setup" "s"
	sleep 0.025
	menu_line_alternate "rEFInd setup" "r"
	sleep 0.025
	menu_line_strong "quit" "q"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			i)
				package_menu
				break # leave this input loop
				;;
			s)
				system_config_menu
				break # leave this input loop
				;;
			r)
				refind_menu
				break # leave this input loop
				;;
			q)
				qq
				;;
			*)
				err "not an option."
				continue
				;;
		esac
	done
}

package_menu () {
	inform "Okay. Let's install packages"
	sleep 0.5
	menu_line_alternate "base system" "1"
	sleep 0.025
	menu_line_alternate "console tools" "2"
	sleep 0.025
	menu_line_alternate "sound" "3"
	sleep 0.025
	menu_line_alternate "media tools" "4"
	sleep 0.025
	menu_line_alternate "xorg" "5"
	sleep 0.025
	menu_line_alternate "minimal window manager" "6"
	sleep 0.025
	menu_line_alternate "get YUP" "7"
	sleep 0.025
	menu_line_strong "update system" "u"
	sleep 0.025
	menu_line_strong "refresh pacman keys" "k"
	sleep 0.025
	menu_line_strong "menu" "m"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				installBaseSystem
				break
				;;
			2)
				installConsoleTools
				break
				;;
			3)
				installSound
				break
				;;
			4)
				installMediaTools
				break
				;;
			5)
				installXorg
				break
				;;
			6)
				installMinimalWM
				break
				;;
			7)
				installYUP
				break
				;;
			m)
				top_menu
				break # leave this input loop
				;;
			q)
				qq
				;;
			*)
				err "not an option."
				continue
				;;
		esac
	done
}

system_config_menu () {
	inform "What shall we configure?"
	sleep 0.5
	menu_line_alternate "generate the fstab" "1"
	sleep 0.025
	menu_line_alternate "set the console font" "2"
	sleep 0.025
	menu_line_alternate "set system locale" "3"
	sleep 0.025
	menu_line_alternate "set the timezone" "4"
	sleep 0.025
	menu_line_alternate "enable sane network interface names" "5"
	sleep 0.025
	menu_line_alternate "make new initram img" "6"
	sleep 0.025
	menu_line_alternate "setup pacman reflector" "7"
	sleep 0.025
	menu_line_alternate "set hostname" "8"
	sleep 0.025
	menu_line_strong "menu" "m"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				makeFstab
				break
				;;
			2)
				setTheFont
				break
				;;
			3)
				setupTheLocale
				break
				;;
			4)
				setupTime
				break
				;;
			5)
				setupNetworkDeviceNames
				break
				;;
			6)
				makeInitramFS
				break
				;;
			7)
				setupReflector
				break
				;;
			8)
				setupHostname
				break
				;;
			m)
				top_menu
				break # leave this input loop
				;;
			q)
				qq
				;;
			*)
				err "not an option."
				continue
				;;
		esac
	done
}

refind_menu () {
	inform "rEFInd boot manager"
	sleep 0.5
	menu_line_alternate "install" "1"
	sleep 0.025
	menu_line_alternate "configure" "2"
	sleep 0.025
	menu_line_alternate "theme it" "3"
	sleep 0.025
	menu_line_alternate "manage efi boot entries" "4"
	sleep 0.025
	menu_line_strong "menu" "m"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			m)
				top_menu
				break # leave this input loop
				;;
			q)
				qq
				;;
			*)
				err "not an option."
				continue
				;;
		esac
	done
}


# :. : . : . : . : . : . : . : . : . : . : .:
# : .  actions!!  . :




installBaseSystem () {
	# base base-devel arch-install-scripts reflector
	# linux linux-firmware dosfstools exfat-utils ntfs-3g
	# iwd openssh rsync wget curl git nmap terminus-font
	# avahi nss-mdns
	echo "installing base system"
	sleep 0.5
	package_menu
}

installConsoleTools () {
	# neovim nnn zsh tmux tree fd fzf exa neofetch gdu weechat
	# patch dstat pv htop multitail lftp mutt lm_sensors
	# gitui lazygit python-pip
	# ranger screen atool highlight libcaca lynx w3m mediainfo poppler transmission-cli
	echo "installing console tools"
	sleep 0.5
	package_menu
}

installSound () {
	# alsa-utils pulseaudio pavucontrol paprefs
	echo "installing sound server and controller"
	sleep 0.5
	package_menu
}

installMediaTools () {
	# ffmpeg imagemagick perl-exif-tools youtube-dl
	echo "installing media tools"
	sleep 0.5
	package_menu
}

installXorg () {
	# xorg-server xorg-xinit xorg-xkill xorg-xev xorg-xsetroot xorg-xrdb xorg-xfontsel xscreensaver
	echo "installling xorg"
	sleep 0.5
	package_menu
}

installMinimalWM () {
	# bspwm sxhkd picom viu kitty feh sxiv scrot rofi rofimoji dunst mpv wireless_tools lxappearance-gtk3
	echo "installing BSPWM and friends"
	sleep 0.5
	package_menu
}

installYUP () {
	# git clone https://aur.archlinux.org/yup.git
	# cd yup
	# makepkg -si
	# cd ..
	# rm -rf yup
	echo "installing YUP"
	sleep 0.5
	package_menu
}

makeFstab () {
	#genfstab -U -p $1 >> $1/etc/fstab
	echo "generating a new fstab in $sys_root/etc/fstab."
	sleep 0.5
	system_config_menu
}

setTheFont () {
	#echo FONT=ter-v32n > /etc/vconsole.conf
	#setfont ter-v32n
	echo "setting the console font to ter-v32n"
	sleep 0.5
	system_config_menu
}

setupTheLocale () {
	#cp configs/locale.gen /etc/locale.gen
	#export LANG=en_GB.UTF-8
	#locale-gen
	echo "setting the lang and generated new locale"
	sleep 0.5
	system_config_menu
}

setupTime () {
	#ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
	#timedatectl set-ntp true
	echo "setting the timezone and ntp"
	sleep 0.5
	system_config_menu
}

setupNetworkDeviceNames () {
	#ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
	echo "setting more sane network device names"
	sleep 0.5
	system_config_menu
}

makeInitramFS () {
	#cp configs/mkinitcpio.conf /etc/mkinitcpio.conf
	#mkinitcpio -p linux
	echo "copying mkinitcpio config and compiling a new image"
	sleep 0.5
	system_config_menu
}

setupReflector () {
	#cp configs/reflector.conf /etc/xdg/reflector/reflector.conf
	#systemctl enable reflector
	echo "copying reflector config and enabling"
	sleep 0.5
	system_config_menu
}

setupHostname () {
	# if [ -d "$1" ]; then
	# 	hostnamectl set-hostname $1
	# 	hostnamectl set-icon-name computer
	# 	hostnamectl set-chassis desktop
	# else
	# 	echo -e "Give me a new hostname to set:"
	# 	echo -e "$\t./setHostname.sh new-hostname"
	# fi
	echo "setting the hostname"
	sleep 0.5
	system_config_menu

}


# :. : . : . : . : . : . : . : . : . : . : .:
# : .  the script  . :




# to clear the colors when exited using SIGINT
trap 'printf "\033[0m";exit 1' INT HUP

if [ -z $1 ]; then
	usage
	exit
fi

sys_root=$1
if ! [ -d "$sys_root" ]; then
	warn "$sys_root" "is not a real directory."
	exit
else
	logo
	top_menu
fi


