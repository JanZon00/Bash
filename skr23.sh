#! /usr/bin/bash
# Jan Zoń pjs gr1

if [ $# -ne 3 ]; then
	echo "wrong number of arguments, expected 3"
	echo "for multiplication input \*"
	exit 1
fi


if [[ "$1" =~ [-+*/%^] ]]; then
	operator=$1
	a=$2
	b=$3
elif [[ "$2" =~ [-+*/%^] ]]; then
	a=$1
	operator=$2
	b=$3
elif [[ "$3" =~ [-+*/%^] ]]; then
	a=$1
	b=$2
	operator=$3
else
	echo "operator not found"
	exit 2
fi

re='^-?[0-9]+$'
if ! [[ $a =~ $re ]] || ! [[ $b =~ $re ]]; then
	echo "not a number"
	exit 1
fi

if [ "$a" -lt "$b" ]; then
	for (( x=a; x<=b; x++ ))
	do
		for (( y=a; y<=b; y++ ))
		do

			result=$(( x $operator y ))
			echo -n "$result "
		done
		printf "\n"
	done
else
	for (( x=a; x>=b; x-- ))
	do
		for (( y=a; y>=b; y-- ))
		do
			result=$(( x $operator y ))
			echo -n "$result "
		done
		printf "\n"
	done
fi
