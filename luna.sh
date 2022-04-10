# :::::::::::::::::::::::::::::::::::::::::::
#  Luna, the Arch Linux Install Configurator

#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# Project repository: https://github.com/leafybear/luna

#  A. Bentley (leafybear@icloud.com)
#  edit: 2022
# :. : . : . : . : . : . : . : . : . : . : .:

#!/bin/bash



# initial bootstrap: system creation (install)
	# base system
	# make fstab
# chroot in system: initial setup (chroot)
	# console font
	# locale
	# timezone
	# initramfs img
	# pacman reflector
	# refind
	# -> install more packages
# after first boot: further config (first boot)
	# get YUP
	# set passwd for root
	# make a user
	# update the system
	# -> install more packages

# Use external shell scripts to execute changes so that they can be updated easier by me or others



# :. : . : . : . : . : . : . : . : . : . : .:
# : .    formatting    . :



logo () {
	echo "    __                    "
	echo "   / / _   _ _ __   __ _  "
	echo "  / / | | | | '_ \ / _\` | "
	echo " / /__| |_| | | | | (_| | "
	echo " \____/\__,_|_| |_|\__,_| "
	echo " an Arch Linux install tool"
	echo
}

err () { # display an error message to stderr
	printf "\033[0;31m%s\033[0m\n" "$*" >&2
}

inform () { # a green info message
	printf "\033[0;32m%s\033[0m\n" "$1"
}

prompt () { # prompt the user a message ($1) and saves the input as $REPLY
	printf "\033[0;34m%s: \033[0m" "$1"
	read -r REPLY
}

warn () { # display a warning in red ($1) and orange ($2)
	printf "\033[0;31m%s \033[0;33m%s\033[0m\n" "$1" "$2"
}

menu_a () { # displays a cyan menu line [$2] $1
	printf "\033[0;34m[\033[0;36m%s\033[1;34m] \033[0;36m%s\033[0m\n" "$2" "$1"
}

menu_b () { # displays a yellow menu line [$2] $1
	printf "\033[0;34m[\033[0;33m%s\033[1;34m] \033[0;33m%s\033[0m\n" "$2" "$1"
}

menu_emph () { # displays a magenta menu line [$2] $1
	printf "\033[0;34m[\033[0;35m%s\033[0;34m] \033[0;35m%s\033[0m\n" "$2" "$1"
}

menu_alt() {
	menuColor=${menuColor:-0}
	if [ "$menuColor" -eq 0 ]; then
		menu_b "$1" "$2"
		menuColor=1
	else
		menu_a "$1" "$2"
		menuColor=0
	fi
}





# :. : . : . : . : . : . : . : . : . : . : .:
# : .     menus    . :




usage() { warn "Usage:" "$(basename $0) /path/to/system/root"; exit; }

qq () {
	echo
	echo "bye"
	sleep 0.1
	exit
}

doChroot () {
	if ! command -v "arch-chroot" >/dev/null ; then
		err "\"arch-chroot\" not found. Please install it."
	else
		arch-chroot $sys_root /bin/bash
		exit
	fi

}


main_menu () {
	# $1 : 0 or 1 to toggle screen clear
	# $2 information text at the beginning of the list
	if [ $1 -eq 1 ]; then tput clear; fi
	inform "$2"
	sleep 0.25
	menu_alt "System creation (install)" "1"
	menu_alt "Initial setup (chroot)" "2"
	menu_alt "Further configuration (first boot)" "3"
	menu_alt "Get more packages" "4"
	menu_emph "quit" "q"
	while :; do
		prompt " ? "
		choice="$REPLY"
		case $choice in
			1)
				system_menu 1 "Install a system"; break;;
			2)
				chroot_menu 1; break;;
			3)
				config_menu 1; break;;
			4)
				package_menu 1 "Install packages"; break;;
			q)
				qq;;
			*)
				err "not an option."
				continue;;
		esac
	done
}

system_menu () {
	# $1 : 0 or 1 to toggle screen clear
	# $2 information text at the beginning of the list
	if [ $1 -eq 1 ]; then tput clear; fi
	inform "$2"
	sleep 0.25
	menu_alt "Bootstrap the system" "1"
	menu_alt "Genereate an fstab" "2"
	menu_emph "back" "b"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				inform "installing a base system"
				./tools/bootstrap.sh $sys_root
				echo; system_menu 0 "What should we do now?"; break;;
			2)
				inform "creating a new fstab"
				./tools/genFstab.sh $sys_root
				echo; system_menu 0 "What should we do now?"; break;;
			b)
				main_menu 1 "What's next?"
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

chroot_menu () {
	# $1 : 0 or 1 to toggle screen clear
	# $2 information text at the beginning of the list
	if [ $1 -eq 1 ]; then tput clear; fi
	inform "$2"
	sleep 0.25
	menu_alt "Chroot to the new system" "1"
	menu_alt "Set the console font" "2"
	menu_alt "Set the system locale" "3"
	menu_alt "Set the timezone" "4"
	menu_alt "Change default network names" "5"
	menu_alt "Make a new initramfs img" "6"
	menu_alt "Setup pacman mirrors" "7"
	menu_alt "Install rEFInd" "8"
	menu_alt "Configure rEFInd" "9"
	menu_emph "back" "b"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				inform "chroot-ing to the new root"
				doChroot
				echo; chroot_menu 0 "What should we do now?"; break;;
			2)
				inform "setting the console font"
				./tools/setFont.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			3)
				inform "setting the system locale"
				./tools/setLocale.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			4)
				inform "setting the timezone"
				./tools/setTime.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			5)
				inform "change default network device names"
				./tools/setSaneDeviceNames.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			6)
				inform "making an initramfs img"
				./tools/mkInitImg.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			7)
				inform "setup pacman mirrors"
				./tools/setupReflector.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			8)
				inform "install rEFInd boot manager"
				./tools/installRefind.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			9)
				inform "configuring rEFInd boot manager"
				./tools/makeRefindConfig.sh
				echo; chroot_menu 0 "What should we do now?"; break;;
			b)
				main_menu 1 "What's next?"
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

config_menu () {
	# $1 : 0 or 1 to toggle screen clear
	# $2 information text at the beginning of the list
	if [ $1 -eq 1 ]; then tput clear; fi
	inform "$2"
	sleep 0.25
	menu_alt "get YUP, arch user repository install" "1"
	menu_alt "set root password" "2"
	menu_alt "make a user" "3"
	menu_alt "update the system" "4"
	menu_alt "refresh pacman's GPG keys" "5"
	menu_emph "back" "b"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				inform "getting YUP, the AUR installer"
				./tools/getYup.sh
				echo; config_menu 0 "What should we do now?"; break;;
			2)
				inform "set the root passwd"
				#passwd root
				echo; config_menu 0 "What should we do now?"; break;;
			3)
				inform "make a user"
				prompt "new username?"
				username="$REPLY"
				#useradd -a -G wheel -s /bin/bash $username
				inform "set their password"
				#passwd $username
				echo; config_menu 0 "What should we do now?"; break;;
			4)
				inform "update the system"
				pacman -Syyu
				echo; config_menu 0 "What should we do now?"; break;;
			5)
				inform "refresh pacman's security keys"
				./tools/refreshPacmanKeys.sh
				echo; config_menu 0 "What should we do now?"; break;;
			b)
				main_menu 1 "What's next?"
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
	# $1 : 0 or 1 to toggle screen clear
	# $2 information text at the beginning of the list
	if [ $1 -eq 1 ]; then tput clear; fi
	inform "$2"
	sleep 0.25
	menu_alt "Console tools (TUI)" "1"
	menu_alt "Sound server and controller" "2"
	menu_alt "Video and audio tools" "3"
	menu_alt "X11 server and drivers" "4"
	menu_alt "Tiling window manager (BSPWM)" "5"
	menu_alt "Bluetooth tools" "6"
	menu_alt "KDE Plasma" "7"
	menu_emph "back" "b"
	while :; do
		prompt "?"
		choice="$REPLY"
		case $choice in
			1)
				inform "installing console tools"
				./tools/installTui.sh
				echo; package_menu 0 "Install something else?"; break;;
			2)
				inform "installing sound server"
				./tools/installSound.sh
				echo; package_menu 0 "Install something else?"; break;;
			3)
				inform "installing video and audio tools"
				./tools/installMediaTools.sh
				echo; package_menu 0 "Install something else?"; break;;
			4)
				inform "installing x11 server and drivers"
				./tools/installX11.sh
				echo; package_menu 0 "Install something else?"; break;;
			5)
				inform "installing minimal tiling window manager BSPWM"
				./tools/installTilingWM.sh
				echo; package_menu 0 "Install something else?"; break;;
			6)
				inform "installing bluetooth tools"
				./tools/installBluetooth.sh
				echo; package_menu 0 "Install something else?"; break;;
			7)
				inform "installing KDE and plasma"
				./tools/installKDE.sh
				echo; package_menu 0 "Install something else?"; break;;
			b)
				main_menu 1 "What's next?"
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
# : .    the script    . :




# to clear the colors when exited using SIGINT
trap 'printf "\033[0m";exit 1' INT HUP

if [ -z $1 ]; then
	usage
	exit
fi

if ! [ -d "configs" ]; then
	err "Luna needs to bu run in the same folder as her config folder."
	exit
fi

if ! [ -d "tools" ]; then
	err "Luna needs to bu run in the same folder as her tools folder."
	exit
fi

sys_root=$1
if ! [ -d "$sys_root" ]; then
	warn "$sys_root" "is not a real directory."
	exit
else
	tput clear
	logo
	main_menu 0
fi


