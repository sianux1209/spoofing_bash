#!/bin/bash

FLAG=true
GATEWAY=$(netstat -rn | grep -e '^0\.0\.0\.0' | awk '{print $2}')

DEFAULT_MAC=$(arp -a | grep ${GATEWAY}")" | awk -F ' ' '{printf $4}')
CHECK_MAC=${DEFAULT_MAC}

while true;
do
        if [ "$DEFAULT_MAC" != "$CHECK_MAC" ]
        then

                echo "DEFAULT MAC = " "$DEFAULT_MAC"
                echo "CHECK   MAC = " "$CHECK_MAC"
                echo "warning!!"
                echo -e $(date) "\n"
                exit
        fi

        echo "DEFAULT MAC = " "$DEFAULT_MAC"
        echo "CHECK   MAC = " "$CHECK_MAC"
        echo -e "safe\n"

        sleep 1
        CHECK_MAC=$(arp -a | grep ${GATEWAY}")" | awk -F ' ' '{printf $4}')

done;


