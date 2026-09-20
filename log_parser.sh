#!/bin/sh

HOMEASSISTANT=192.168.178.26 
DEBUG_FILE=/mnt/mmc01/output.log
#DEBUG_FILE=/dev/null


# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

main() {
    IFS='$\n'
    echo $(date +"%Y-%d-%m %H:%M:%S") + " start" > $DEBUG_FILE
    echo $(date +"%Y-%d-%m %H:%M:%S") + " start" > /mnt/mmc01/mqttsent.log
    while true; do
	read -r BUF;
	if [ $? -ne 0 ]; then
	    sleep 1;
	    continue
	fi
	if contains "$BUF" "--motion detection alarm --"; then
	    echo $(date +"%Y-%d-%m %H:%M:%S") + " motion detected" >> /mnt/mmc01/mqttsent.log
            /mnt/mmc01/mosquitto_pub -h $HOMEASSISTANT -u camera -P camera -m "ON" -t camera/motion
	elif contains "$BUF" "doorbell pressed" || contains "$BUF" "external_charm_ctrl = 1"; then
            echo $(date +"%Y-%d-%m %H:%M:%S") + " doorbell push button" >> /mnt/mmc01/mqttsent.log
            /mnt/mmc01/mosquitto_pub -h $HOMEASSISTANT -u camera -P camera -m "ON" -t camera/button
	#else
	    #echo "Unknown cmd: $BUF"
	fi
	echo $BUF >> $DEBUG_FILE
    done
}

main

