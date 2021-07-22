#!/bin/bash

if [[ "$1" == "" || "$2" == "" ]];then
        printf "\n./offpkg [options] [programs]\n
	v1.0 - hNgz

        -a | --all = get, download and install the packets of the programs automatically
        -g | --get = just get the list of packets of the programs
        -i | --install = install the packets of the programs

                ./offpkg --all nmap whois
                ./offpkg -g dnsutils
                ./offpkg -i *
\n"; exit 0;

fi

OPTIONS=$1
PROGRAMS=$2
APTBIN="apt"

ALL_MAIN()
{

        printf "\n\n\e[1;36m./---------------------------------------------------------------\\\.\e[0m"
        printf "\n\n\t\t\e[1;37m[\e[1;33m*\e[1;37m] DOWNLOADING PACKAGES [\e[1;33m*\e[1;37m]\e[0m\n\n"
        printf "\e[1;36m./---------------------------------------------------------------\\\.\n\n\e[0m"


        for PACKAGE in $($APTBIN install $PROGRAMS --print-uris -qq|grep http|cut -d "'" -f2);do

                # wget -q "$PACKAGE"
		dada

	        if [ ! "$?" == "0" ];then

	        	printf "\n\e[1;31m[+] PACKAGE FAIL: %s [+]\e[0m" "$PACKAGE"
	        	INVALID=1
	       	fi
	done

	if [ "$INVALID" == "1" ];then

		printf "\n\n\e[0mPackages \e[1;31mFAILED \e[0min the Attempt of Download \e[1;34m(try download them manually )\e[0m, would you like to continue the installation ? ( not recommended ) > (y/N) ";read CONFIRM
		[[ "$CONFIRM" == "N" || "$CONFIRM" == "" ]] && exit 0

		dpkg -i *.deb
		printf "\n\n\e[1;37m[\e[1;33m*\e[1;37m] DONE \e[1;37m[\e[1;33m*\e[1;37m]\n\n"
	else
                dpkg -i *.deb
                printf "\n\n\e[1;37m[\e[1;33m*\e[1;37m] DONE \e[1;37m[\e[1;33m*\e[1;37m]\n\n"

        fi

}

GET_MAIN()
{
	$APTBIN install $PROGRAMS --print-uris -qq|grep http|cut -d "'" -f2 | tee offpkg_packets.log
        printf "\n\n\e[1;37m[\e[1;33m*\e[1;37m] DONE! The Log has saved on:\e[1;36m %s/offpkg_packets.log \e[1;37m[\e[1;33m*\e[1;37m]\n\n" "$(pwd)"

}


case "$OPTIONS" in


	-a | --all | -all | -A | --ALL | -ALL )

		ALL_MAIN
		;;

	-g | --get | -get | -G | --GET | -GET )

		GET_MAIN
		;;

	-i | --install | -install | -I | --INSTALL | -INSTALL )

		dpkg -i *$PROGRAMS*.deb
		;;

	*)
		printf "\n\n\e[1;31mINVALID OPTION !!\n\n\e[0m";exit 0;
		;;

esac
printf "\e[0m\n"
