#!/bin/bash

figlet -t -k -f slant Sublist3r pro | lolcat -S 2 -a -s 50
echo -e '\e[1;31mBy Atharva Shirude\e[1;m'

if [ "$1" == "" ]
then
	
  echo -e "\nYou forgot to enter a domain!"
	echo -e "\nSyntax sublist3rpro example.com"

else
	domain=$1
	
	if [ ! -d ~/reports ]; then

		mkdir ~/reports
		

	fi
	
	if [ ! -d ~/reports/$domain ]; then
		
    mkdir ~/reports/$domain
		cd ~/reports/$domain
	

		curl -s --request GET --url "https://api.securitytrails.com/v1/domain/$domain/subdomains?children_only=false&include_inactive=true" --header 'apikey: ENTER_YOUR_API_KEY_HERE' >> sub.txt 
		     


		echo -e "\n\n***** Domain: $domain *****"

		#cat sub.txt | grep -oP '\".*?\"' | grep -Pzo '.*\"subdomains\"(.*\n)*'
		grep -v "{\|}\|\[\|\]\|subdomain_count\|limit_reached\|endpoint" sub.txt | cut -f2 -d "\"" | sed "s/$/.$domain/g"  >> subdomains.txt
		echo -e '\n\e[1;31mSubdomians\e[1;m'
		cat subdomains.txt 

		filename_subdomain=$(cat subdomains.txt)
		for subdomain in $filename_subdomain
		do 
			echo -e "\n+++++++++++++++++++++++++++++++++++" >> ip.txt 
			
      echo -e "$subdomain" >> ip.txt 
			
			ipgrab=$(echo $subdomain | host $subdomain | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') >> ip.txt 
			
			iplist=$(echo $ipgrab)
			
			echo +++++++++++++++++++++++++++++++++++ >> ip.txt 
			
			i=1
			x=" "
			words=$(echo $ipgrab | wc -w)
			
			for ((n=$i;n<=$words;n++))
			do
			  
			  ip=$(echo $iplist | cut -f$n -d " ")
			  echo ----------------------------------- >> ip.txt
			  echo -e "$ip\n" >> ip.txt
			  whois $ip | grep "NetName:\|NetRange\|CIDR" >> ip.txt
		
			done
			
		done
		cat ip.txt
		rm sub.txt
		echo -----------------------------------
	
  else
		echo -e "\nFile already exists! \npath: ~/reports/$domain"
		cd ~/reports/$domain
		echo -e "\n\n***** Domain: $domain *****"
		cat subdomains.txt 
		cat ip.txt
	fi

fi
