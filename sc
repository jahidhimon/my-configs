#! /bin/bash

while (echo -n "Enter Link ==> ") && read input
do
    youtube-dl -f bestaudio --extract-audio $input
		echo ""
done
