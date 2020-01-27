#!/bin/bash
if test "$1" != ""
then
	if test "$2" != ""
	then
		echo "HIMM $1 $2" 
	else
		echo "Second variable is null"
	fi
else
		echo "First variable is null"
fi