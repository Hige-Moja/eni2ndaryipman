#!/bin/sh
count=0
CONF=/opt/eni2ndaryipman/eni-id.txt
echo "# ENI Secondary IP Manager Settings"   >  ${CONF}
echo "# Created by precheck at $(/bin/date)" >> ${CONF}
while read line
do
    MAC=$(ssh ${line}   -n /bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
    ENIID=$(ssh ${line} -n /bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC}/interface-id)
    echo "${ENIID}" >> ${CONF}
    count=$((++count))
done < /opt/eni2ndaryipman/iplist.txt
