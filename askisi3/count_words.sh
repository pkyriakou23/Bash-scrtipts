#!/bin/bash


file=$1
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
	echo "This script find the n most frequent word"
else
	n=$2
	touch text.txt
	touch temp.txt
	while read line; do
		start=${line:0:41}
		end=${line:0:39}
		st="*** START OF THIS PROJECT GUTENBERG EBOOK"
		en="*** END OF THIS PROJECT GUTENBERG EBOOK"	
		if [[ "$start" == "$st" ]]; then
			continue
		fi
		if [[ "$end" == "$en" ]]; then
			break
		fi
	
		echo "$line" >> text.txt
	done<$file

	tr -c '[:alnum:]' '[\n*]' < text.txt | tr -cs A-Za-z\' '\n' | sort | uniq -c | sort -nr | head  -$n > temp.txt

	rm text.txt

	while read line; do

	remv=" "
	t=${line//$remv/}
	echo "${t//[0-9]/} ${t//[!0-9]/}"


done<temp.txt
fi
