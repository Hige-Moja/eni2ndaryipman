#!/bin/sh
SCRDIR=/opt/eni2ndaryipman
. ${SCRDIR}/secondaryip.conf

while read line 
do
    if [[ ${line} =~ ^#.*$ ]] ;then
        continue
    fi
    /usr/local/bin/aws ec2 unassign-private-ip-addresses --network-interface-id ${line} --private-ip-addresses ${SECONDARYIP} 2> /dev/null
    count=$((++count))
done < ./eni-id.txt

MYMAC=$(/bin/curl -s   http://169.254.169.254/latest/meta-data/network/interfaces/macs/)
MYENIID=$(/bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MYMAC}/interface-id)
/usr/local/bin/aws ec2 assign-private-ip-addresses --network-interface-id ${MYENIID} --private-ip-addresses ${SECONDARYIP}
