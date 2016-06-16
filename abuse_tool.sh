#!/bin/bash
#author:sparklingSky

printf "Enter the filename of your input data: \n"

read input_file

printf "For DNS check: press 'D' \nFor NTP check: press 'N' \nFor SNMP check: press 'S'\nTo soRt IP adresses: press 'R'\nTo run 'host' command: press 'H'\nTo get naMeservers: press 'M'\nTo process RT rss file: press 'T'\n"

read type 

type=`echo "${type^^}"`

timestamp=`date +"%m-%d|%H:%M"`

echo "Processing data..."

if [[ "$type" = "D" ]]
then
  for i in `cat $input_file`; 
     do 
	echo $i; 
	  dig google.com @${i}|grep -i "flags\|size"; printf "\n";
     done >> ${timestamp}_dns_out.txt 2>>${timestamp}_dns_out.txt

echo "Completed. See results in file ${timestamp}_dns_out.txt"

elif [[ "$type" = "N" ]]
then
  for i in `cat $input_file`; 
     do echo $i; ntpdc -c monlist $i|head -n 2; printf "\n";
     done >> ${timestamp}_ntp_out.txt 2>>${timestamp}_ntp_out.txt

echo "Completed. See results in file ${timestamp}_ntp_out.txt"
echo "Note: only first two lines of the NTP server's response are shown."

elif [[ "$type" = "S" ]]
then
  for i in `cat $input_file`;
    do echo $i; snmpwalk -v2c -c public $i|head -n 2; printf "\n";
    done >> ${timestamp}_snmp_out.txt 2>>${timestamp}_snmp_out.txt

echo "Completed. See results in file ${timestamp}_snmp_out.txt"
echo "Note: only first two lines of the SNMP server's response are shown."

elif [[ "$type" = "R" ]]
then
  sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 $input_file >> ${timestamp}_sorted_ips.txt 

echo "Completed. See results in file ${timestamp}_sorted_ips.txt"

elif [[ "$type" = "H" ]]
then
   for i in `cat $input_file`; 
     do echo $i; host $i | grep address; printf "\n";
     done >> ${timestamp}_host_out.txt

echo "Completed. See results in file ${timestamp}_host_out.txt"

elif [[ "$type" = "M" ]]
then
  for i in `cat $input_file`; do echo $i; whois $i | grep -i -e "name server" -e nserver ; printf "\n";
  done >> ${timestamp}_nameservers_out.txt

echo "Completed. See results in file ${timestamp}_nameservers_out.txt"

elif [[ "$type" = "T" ]]
then
  cat $input_file|tr -d '\n'|tr '\ ' '\n'|tr '\t' '\n'|sed -e 's/http\:\/\//\nhttp\:\/\//g' -e 's/https\:\/\//\nhttps\:\/\//g' |grep "^http://\|^https://" |sort -n | uniq > out.txt
  
echo "Completed. See results in file out.txt"

fi
