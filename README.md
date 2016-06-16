**abuse_tool.sh**

This bash script is designed:
- to do a bulk check of DNS servers (whether they are open (recursive) resolvers or have excessive data in their response, vulnerability which can be used for DNS DDoS amplification);
- to do a bulk check of NTP servers (whether they respond to any 3rd-party monlist requests, vulnerability which can be used for NTP DDoS amplification);
- to do a bulk check of SNMP servers (whether they have a default community string set to 'public' and respond to any any 3rd-party requests, vulnerability which can be used for SNMP DDoS amplification);
- to sort the list of IP adresses;
- to run a 'host' command for a list of domains;
- to output all nameservers of the listed domains;
- to process a text file and output the list of all the URLs it contains. 

Input data must be saved in a file located in the same folder where the script is.
