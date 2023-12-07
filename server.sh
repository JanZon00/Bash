#! /usr/bin/bash
# Jan Zoń pjs gr1

port=12345
counter_file="counter.rc"
counter=0

save_counter_state() {
	> $counter_file
	echo "$counter" > "$counter_file"
	echo "$port" >> "$counter_file"
}

load_counter_state() {
	if [ -f "$counter_file" ]; then
		counter=$(head -n 1 "$counter_file")
	else
		counter=0
	fi
}

run_client() {
	nc 127.0.0.1 $port
	echo "client is running..."
	load_counter_state
	((counter++))
	save_counter_state "$counter"
	exit 1
}

run_server() {
	previous_port=$(tail -n 1 "$counter_file")
	if [ $previous_port -ne $port ]; then
		counter=0
		save_counter_state "$counter"
	fi

	counter=$(head -n 1 "$counter_file")
	echo "Running server on port $port. Number of calls : $counter"
	nc -l localhost $port
}

while getopts "csp:" opt; do
	case "$opt" in
		c)
		run_client
		;;
		s)
		run_server
		;;
		p)
		port="$OPTARG"
		;;
	esac
done

run_server
