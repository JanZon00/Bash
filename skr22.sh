#! /usr/bin/bash
# Jan Zoń pjs gr1

if [ $# -ge 2 ]; then
a=$1
b=$2
re='^-?[0-9]+$'
if ! [[ $a =~ $re ]] || ! [[ $b =~ $re  ]] ; then
	echo "not a number"
	exit 1;
fi

		if [ "$a" -lt "$b" ]; then
			for (( x=a; x<=b; x++ ))
			do
				for (( y=a; y<=b; y++ ))
				do
					result=$(( x*y ))
					echo -n "$result "
				done
				printf "\n"
			done
		else
			for (( x=a; x>=b; x-- ))
			do
				for (( y=a; y>=b; y-- ))
				do
					result=$(( x*y ))
					echo -n "$result "
				done
				printf "\n"
			done
		fi

elif [ $# -eq 1 ]; then
a=1
b=$1
re='^-?[0-9]+$'
if ! [[ $b =~ $re ]]; then
	echo "not a number"
	exit 1;
fi
	if [ "$a" -lt "$b" ]; then
		for (( x=a; x<=b; x++ ))
		do
			for (( y=a; y<=b; y++ ))
			do
				result=$(( x*y ))
				echo -n "$result "
			done
			printf "\n"
		done
	else
		for (( x=b; x<=a; x++ ))
		do
			for (( y=b; y<=a; y++ ))
			do
				result=$(( x*y ))
				echo -n "$result "
			done
			printf "\n"
		done
	fi
else
	for value in {1..9}
	do
		for value2 in {1..9}
		do
			a=$(( value*value2 ))
			echo -n "$a "
		done
		printf "\n"
	done
fi
