#!/bin/bash
file=$1

while read line; do
a=${line:0:1}

#elexei an i grammi ksekinaei me # gia na tin agnoisi
if [ "$a" = "#" ]
then
a=$line
else
name="$line-old"
url=$line
nameN="$line-new"

#krataei to base gia na onomasi ton fakelo
remv="http://"
name=${name//$remv/}
remv="https://"
name=${name//$remv/}
remv="/"
name=${name//$remv/-}
remv="http://"
nameN=${nameN//$remv/}
remv="https://"
nameN=${nameN//$remv/}
remv="/"
nameN=${nameN//$remv/-}

#elexei an iparxi o fakelos
if [[ -f "$name" ]]
then
#	katevazi tin istoselida elexontas tautoxrona an egine epitixo kai tiponi katallilo minima
	if wget -q -O $nameN $url --no-check-certificate ;
	then if cmp -s $nameN $name ; then 
			mv $nameN $name	
		else
			echo "$url"
			mv $nameN $name
		fi
	else 
		echo "$url FAILED" >&2	
	fi
else
#an den iparxi to file simeni pos einai i proti fora kai to dimiourga kai katevazi ta stoixeia tis istoselidas tiponontas katalilo minima
	touch $name

	if wget -q -O $name $url --no-check-certificate ;
	then echo "$url INIT"
	else echo "$url FAILED" >&2
	fi
fi
fi
done<$file
