#!/bin/sh

usage_and_exit () {
        echo "Error, $*, exiting"
        exit 1
}
# Script based on script from:
# http://www.crashcourse.ca/wiki/index.php/Huawei_3G_modem_on_Ubuntu
# (CC-BY-SA)

# Sample invocation of this script:
#
# $ ./3g.sh "randomname" "internet.com" '*99***1#'
#
# The first argument is simply a name you choose for that provider
# that will be useful for upcoming diagnostics; currently, it's
# unused so you can put whatever you want in there.

PROVIDER=$1
APN=$2
DIALSTRING=$3

echo "PROVIDER = ${PROVIDER}"
echo "APN = ${APN}"
echo "DIALSTRING = ${DIALSTRING}"   

[ -n "${PROVIDER}" ]            || usage_and_exit "Null PROVIDER string"
[ -n "${APN}" ]                 || usage_and_exit "Null APN string"
[ -n "${DIALSTRING}" ]          || usage_and_exit "Null DIALSTRING string"

[ -c /dev/ppp ]                 || usage_and_exit "/dev/ppp doesn't exist"
[ -c /dev/ttyUSB0 ]             || usage_and_exit "/dev/ttyUSB0 doesn't exist"
[ -f /var/lock/LCK..ttyUSB0 ]   && usage_and_exit "ttyUSB0 already locked"

export APN DIALSTRING

minicom -S dialscript &

sleep 10

# echo "Returned from dialscript, let's check if everything looks sane."

# if [ -f /var/lock/LCK..ttyUSB0 ] ; then
#         echo "Lock file still there, it really shouldn't be."
# fi

# sudo pppd debug -detach defaultroute /dev/ttyUSB0 38400 &