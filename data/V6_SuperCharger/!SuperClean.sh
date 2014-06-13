#!/system/bin/sh
#
# SuperClean & ReStart Script (Wipe Dalvik Cache & Reboot) created by -=zeppelinrox=-
#
# V6U9RC12B34ST
#
# When using scripting tricks, ideas, or code snippets from here, GIVE PROPER CREDIT.
# There are many things may look simple, but actually took a lot of time, trial, and error to get perfected.
# So DO NOT remove credits, put your name on top, and pretend it's your creation.
# That's called kanging and makes you a dumbass.
#
# This script can be used freely and can even be modified for PERSONAL USE ONLY.
# It can be freely incorporated into ROMs - provided that proper credit is given WITH a link back to the XDA SuperCharger thread.
# If you want to share it or make a thread about it, just provide a link to the main thread.
#      - This ensures that users will always be getting the latest versions.
# Prohibited: Any modification (excluding personal use), repackaging, redistribution, or mirrors of my work are NOT PERMITTED.
# Thanks, zeppelinrox.
#
clear
line=================================================
echo ""
echo $line
echo "  -=SuperClean & ReStart=- by -=zeppelinrox=-"
echo $line
echo ""
sleep 1
id=$(id); id=${id#*=}; id=${id%%[\( ]*}
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	sleep 2
	echo " You are NOT running this script as root..."
	echo ""
	sleep 3
	echo $line
	echo "                      ...No SuperUser For You!!"
	echo $line
	echo ""
	sleep 3
	echo "     ...Please Run as Root and try again..."
	echo ""
	echo $line
	echo ""
	sleep 3
	exit 69
fi
echo " Commencing SuperClean & ReStart!"
echo ""
sleep 2
for cachedir in /*/dalvik-*; do rm -r $cachedir/* 2>/dev/null; done
echo " All cleaned up and ready to..."
echo ""
sleep 2
echo $line
echo "                    !!POOF!!"
echo $line
echo ""
sleep 2
busybox sync
if [ -f "/proc/sys/kernel/sysrq" ]; then
	echo 1 > /proc/sys/kernel/sysrq 2>/dev/null
	echo b > /proc/sysrq-trigger 2>/dev/null
fi
echo "  If it don't go poofie, just reboot manually!"
echo ""
reboot; busybox reboot
echo "          ==========================="
echo "           ) SuperClean Completed! ("
echo "          ==========================="
echo ""
sleep 1
exit 0
