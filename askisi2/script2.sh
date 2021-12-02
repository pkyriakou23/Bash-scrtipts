#!/bin/bash
file='texts.txt'
if [ ! -d "assignments" ];
then
	mkdir "assignments"
fi
#vriski kai apothikeui ta arxio txt se ena file
find . -name "*.txt" > texts.txt

while read line;
do
name="$line"
remv="*/"
Clearname=${name//$remv/}
#echo "$Clearname"
if [[ "$Clearname" = "texts.txt" ]]
then
	continue
fi
while read inLine;
do
	a=${inLine:0:1}
	b=${inLine:0:5}
	if [[ "$a" = "#" ]]
	then
		a=$line
	elif [[ "$b" = "https" ]]
	then	
		if git clone "$inLine" assignments --quiet;	
		then
			echo "$inLine: Cloning OK"
		else
			echo "$inLine: Cloning FAILED" >&2
		fi
		break	
		
	else
		a=$inLine
		break
		
	fi
done<$name

done<$file

cd "assignments"

for dir in */; do #mpaino se kathe repo
	cd "$dir"
	d=0		#directories	
	f=0 		#ola ta file
	ftxt=0 		#txt file
	ena=1 
	a="nop"	 	#a.txt an iparxi
	more="nop" 	#...
	b="nop" 	#...
	c="nop" 	#...
	
	#ipologizo sinolika posa file iparxoun
	for file in *; do
		if [ -f "$file" ] ; then		
			f=$((f+ena))
			if [[ "$file" == "*.txt" ]];
			then
				ftxt=$((ftxt+ena))
			fi
		fi
		
	done

	#metro posa dir exei to mesa kai posa file to kathe dir mesa
	for dirc in */; do	
		cd "$dirc"
		for fileb in *; do
		if [ -f "$fileb" ] ; then		
			f=$((f+ena))
			if [[ "$fileb" == "*.txt" ]];
			then
				ftxt=$((ftxt+ena))
			fi
		fi
		done
		d=$((d + ena))
		cd ..
	done

	#elexo an iparxoun ta a,b,c,more
	atxt="dataA.txt"
	btxt="dataB.txt"
	ctxt="dataC.txt"
	mr="more"
	if [ -f "$atxt" ]; then
		a="OK"
	fi
	if [ -d "$mr" ]; then
		more="OK"
		cd "$mr"
		if [ -f "$btxt" ]; then
			b="OK"
		fi
		if [ -f "$ctxt" ]; then
			c="OK"
		fi
	fi
	otherf=$((f-ftxt))
	ok="OK"
	#tipoma apotelemsaton
	echo "$dir:"
	echo "Number of directories: $d"
	echo "Number of txt files: $ftxt"
	echo "Number of other: $otherf"
	if (( "$otherf" == 0 )) && (( "$ftxt" == 3 )) && (( "$d" == 1 )) && [[ "$a" -eq "$ok" ]] && [[ "$b" -eq "$ok" ]] && [[ "$c" -eq "$ok" ]] && [[ "$more" -eq "$ok" ]];
then
	echo "Directory structure is OK"
else	
	echo "Directory structure is NOT OK" >&2
fi

	cd ..
done
