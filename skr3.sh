#! /usr/bin/bash
# Jan Zoń pjs gr1

ip_is_valid() {
	local ip=$1
	local stat=1

	if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		OIFS=$IFS
		IFS="."
		ip=($ip)
		IFS=$OIFS
		[[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
			&& ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
		stat=$?
	fi
	return $stat
}

if [ $# -lt 2 ]; then
	echo "wrong number of arguments, expected 2"
	exit 1
fi

if [[ "$1" < "$2" ]]; then
	ip_start="$1"
	ip_end="$2"
else
	ip_start="$2"
	ip_end="$1"
fi

if ! ip_is_valid "$ip_start" || ! ip_is_valid "$ip_end"; then
	echo "Ip address is not valid"
	exit 1
fi


IFS="." read -ra start_parts <<< "$ip_start"
IFS="." read -ra end_parts <<< "$ip_end"

for ((i = ${start_parts[3]}; i <= ${end_parts[3]}; i++)); do
	current_ip="${start_parts[0]}.${start_parts[1]}.${start_parts[2]}.$i"
	if ping -c 1 -W 1 "$current_ip" &>/dev/null; then
		status="alive"
	else
		status="dead"
	fi
	echo "$current_ip $status"
done
