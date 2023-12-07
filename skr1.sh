#! /usr/bin/bash
# Jan Zoń pjs gr1

user_login=$(getent passwd "$USER" | cut -d: -f1)
user_fullname=$(getent passwd "$USER" | cut -d: -f5 | cut -d, -f1)

help(){
	echo "Author : Jan Zon"
	echo "This script displays name, surname and"
	echo "the password of the currently logged in user"
	echo "Use -h or --h to show help"
	echo "Use -q or --quiet to end the script"
}

help_found=0
quiet_found=0

for arg in "$@"; do
	if [ "$arg" == "-h" ] || [ "$arg" == "--help" ]; then
		help_found=1
	elif [ "$arg" == "-q" ] || [ "$arg" == "--quiet" ]; then
		quiet_found=1
	fi
done

if [ $# -eq 0 ]; then
	echo "Login : $user_login"
	echo "Name and surname : $user_fullname"
elif [ $help_found -eq 1 ]; then
	help
elif [ $quiet_found -eq 1 ]; then
	:
else
	exit 0;
fi
