#! /usr/bin/bash
# Jan Zoń pjs gr1

for value in {1..9}
do
	for value2 in {1..9}
	do
		a=$(( value*value2 ))
		echo -n "$a "
	done
	printf "\n"
done
