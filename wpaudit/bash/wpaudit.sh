#!/bin/bash

figlet -t -k -f slant wpfuzz | lolcat -S 2 -a -s 50
echo -e '\e[1;31mBy Atharva Shirude\e[1;m'

website="https://www.example.com/"

fuxx=$(cat wpfuxx.txt)
echo -e '\e[5mFuzzzzingg . . . .\e[1;m'
echo -e "URLs with status code 200\n" >> wp fuzz.txt
for directory in $fuxx
do
	wpurls=$(echo $website$directory)
	
	#echo -e "\n$s" >> wpfuzz.txt
	statuscode=$(curl -s -I $wpurls | sed -n '1p' | grep -o "200" &)   
	
	if [ "$statuscode" = "200" ];
	then 
		echo -e "$wpurls" >> wpfuzz.txt
	fi
	
done
echo -e '\e[5mFuzzzzed . . . .\e[1;m'
cat wpfuzz.txt
