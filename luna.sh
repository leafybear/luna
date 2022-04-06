# :::::::::::::::::::::::::::::::::::::::::::
#  Luna, the Arch Linux Install Configurator


#  A. Bentley (leafybear@icloud.com)
#  edit: 2022
# :. : . : . : . : . : . : . : . : . : . : .:
#!/bin/bash

VERSION="0.1"

# :. : . : . : . : . : . : . : . : . : . : .:

help_text () {
	while IFS= read -r line; do
		printf "%s\n" "$line"
	done <<-EOF

	Usage:
	  ${0##*/} [-v] [-q <quality>] [-a <episode>] [-d | -p <download_dir>] [<query>]
	  ${0##*/} [-v] [-q <quality>] -c
	  ${0##*/} -h | -D | -U | -V

	Options:
	  -V print version number and exit

	Episode selection:
	  Add 'h' on beginning for episodes like '6.5' -> 'h6'
	  Multiple episodes can be chosen given a range
	    Choose episode [1-13]: 1 6
	    This would choose episodes 1 2 3 4 5 6
		To select the last episode use -1

	  When selecting non-interactively, the first result will be
	  selected, if anime is passed
	EOF
}

version_text () {
	inf "Version: $VERSION" >&2
}

# :. : . : . : . : . : . : . : . : . : . : .:

# to clear the colors when exited using SIGINT
trap 'printf "\033[0m";[ -f "$logfile".new ] && rm "$logfile".new;exit 1' INT HUP

while getopts 'vq:dp:chDUVa:' OPT; do
	case $OPT in
		h)
			help_text
			exit 0
			;;
		d)
			is_download=1
			;;
		V)
			version_text
			exit 0
			;;
		*)
			help_text
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

# check for main dependencies
dep_ch "curl" "sed" "grep" "git" "openssl"

# check for optional dependencies
if [ "$is_download" -eq 0 ]; then
	dep_ch "$player_fn"
else
	dep_ch "aria2c" "ffmpeg"
fi
# gogoanime likes to change domains but keep the olds as redirects
base_url=$(curl -s -L -o /dev/null -w "%{url_effective}\n" https://gogoanime.cm)
case $scrape in
	query)
		if [ -z "$*" ]; then
			prompt "Search Anime"
			query="$REPLY $REPLY2"
		else
			if [ -n "$ep_choice_to_start" ]; then
				REPLY=1
				select_first=1
			fi
			query="$*"
		fi
		process_search
		;;
	history)
		search_history
		[ "$REPLY" = "q" ] && exit 0
		first_ep_number=0
		result=$(get_dpage_link "$anime_id" "$first_ep_number")
		[ -z "$result" ] && first_ep_number=1
		;;
	*)
		die "Unexpected scrape type"
esac

check_input
append_history
open_selection

########
# LOOP #
########

while :; do
if [ -z "$select_first" ]; then
	if [ "$auto_play" -eq 0 ]; then
		inf "Currently playing $selection_id episode" "$episode/$last_ep_number"
	else
		auto_play=0
	fi
	[ "$episode" -ne "$last_ep_number" ] && menu_line_alternate 'next episode' 'n'
	[ "$episode" -ne "$first_ep_number" ] && menu_line_alternate 'previous episode' 'p'
	[ "$last_ep_number" -ne "$first_ep_number" ] && menu_line_alternate 'select episode' 's'
	menu_line_alternate "replay current episode" "r"
	menu_line_alternate "search for another anime" "a"
	menu_line_alternate "search history" "h"
	menu_line_alternate "select quality (current: $quality)" "b"
	menu_line_strong "exit" "q"
	prompt "Enter choice"
	# process user choice
	choice="$REPLY"
	case $choice in
		n)
			ep_choice_start=$((episode + 1))
			ep_choice_end=
			;;
		b)
			prompt "Select quality. Options (best|worst|360|480|720|1080)"
			quality="$REPLY"
			;;
		p)
			ep_choice_start=$((episode - 1))
			ep_choice_end=
			;;
		s)
			episode_selection
			;;
		r)
			ep_choice_start=$((episode))
			ep_choice_end=
			;;
		a)
			search_another_anime
			;;
		h)
			search_history
			;;
		q)
			break
			;;
		*)
			tput clear
			err "Invalid choice"
			continue
			;;
	esac
	check_input
	append_history
	open_selection
else
	wait $!
	exit
fi
done
