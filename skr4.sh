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

check_port() {
	local ip=$1
	local port=$2

	if nc -z -w 1 "$ip" "$port" &>/dev/null; then
		echo "Port $port on $ip is open. Service: "
		service_info=$(nmap -Pn -p "$port" --open -T4 "$ip" | grep "^$port" | awk '{print $3}')
		if [ -z "$service_info" ]; then
			echo "Cannot recognise the service"
		else
			echo "$service_info"
		fi

	else
		echo "Port $port on $ip is closed"
	fi
}

if [ $# -ne 3 ]; then
	echo "wrong number of arguments, expected at least 3"
	exit 1
fi

ip_start="$1"
ip_end="$2"
port_list="$3"

if ! ip_is_valid "$ip_start" || ! ip_is_valid "$ip_end"; then
	echo "Ip address is not valid"
	exit 1
fi

IFS="." read -ra start_parts <<< "$ip_start"
IFS="." read -ra end_parts <<< "$ip_end"

for port in $(echo "$port_list" | tr ',' ' '); do
	for ((i = ${start_parts[3]}; i <= ${end_parts[3]}; i++)); do
		current_ip="${start_parts[0]}.${start_parts[1]}.${start_parts[2]}.$i"
		check_port "$current_ip" "$port"
	done
done
