#!/bin/sh
/bin/sh  /opt/eni2ndaryipman/get-eni-id.sh
. ./secondaryip.conf
# check1
MAC=$(/bin/curl -s 169.254.169.254/latest/meta-data/mac)
ENI=$(/bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC}/interface-id)
/bin/curl -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/${MAC}/local-ipv4s | /bin/grep ${SECONDARYIP} \
&& /bin/echo "Already assigned SECONDARYIP on ${ENI}" \
&& exit 1

# check 2
/sbin/ip a | /bin/grep ${SECONDARYIP} > /dev/null 2>&1 && exit 1 || exit 0
