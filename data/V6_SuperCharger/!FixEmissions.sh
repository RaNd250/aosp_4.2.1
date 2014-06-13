#!/system/bin/sh
#
# Fix Emissions Script (Fix Permissions) created by -=zeppelinrox=-
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
# Sets permissions for android data directories and apks.
# This should fix app force closes (FCs).
#
# The code is HIGHLY optimized... so it's REALLY FAST! - setting permissions for 300 apps in approximately 1 minute.
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Only applies permissions if they are not what they're supposed to be!
#      - Removed the usage of the "pm list packages" command - it didn't work on boot.
#      - Added support for /vendor/app (POST-ICS).
#      - No longer excludes framework-res.apk or com.htc.resources.apk
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging.
#      - Enhanced logging!
#      - Tweaked interface... just a bit ;^]
#
# Props: Originally and MOSTLY (erm... something like 75% of it lol) by Jared Rummler (JRummy16).
# However, I actually meshed together 3 different Fix Permissions scripts and added my own spices ;^]
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Log_FixEmissions.log file to see what may have fubarred.
# set -x
# exec > /data/Log_FixEmissions.log 2>&1
#
line=================================================
cd "${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
bootupdelay="sleep 300"
# Next line only applies to the init.d boot script. "bootfixemissions=1" means run on boot. Anything else disables it.
bootfixemissions=0
Configure(){
	echo ""
	echo " Fix Emissions On Boot..."
	echo " ========================"
	echo ""
	sleep 1
	echo " If desired, you can change boot options.."
	echo ""
	sleep 1
	echo "        ...this script is VERY sophisticated..."
	echo ""
	sleep 1
	echo "           ...so boot time would be unaffected!"
	echo ""
	sleep 1
	echo $line
	echo -n " Status: Fix Emissions "
	if [ "$bootfixemissions" -eq 1 ]; then echo "DOES Run On Boot!"
	else echo "DOES NOT Run On Boot!"
	fi
	echo $line
	echo ""
	sleep 1
	echo " You can also configure this in Driver Options!"
	echo ""
	sleep 1
	echo $line
	echo "   Also READ THE COMMENTS inside this script!"
	echo $line
	echo ""
	sleep 1
	echo " Change Fix Emissions Options?"
	echo ""
	sleep 1
	echo -n " Enter Y for Yes, any key for No: "
	read changeoptions
	echo ""
	echo $line
	case $changeoptions in
		y|Y)mount -o remount,rw /system 2>/dev/null
			busybox mount -o remount,rw /system 2>/dev/null
			busybox mount -o remount,rw $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
			echo ""
			sleep 1
			echo " Run Fix Emissions on boot?"
			echo ""
			sleep 1
			echo " Note: If you say Yes, Fix Alignment On Boot..."
			echo "      ...gets disabled (avoids overlapping mods)"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootfixemissions
			echo ""
			echo $line
			case $bootfixemissions in
			  y|Y)fixemissions=1; fixalign=0
				  echo "        Fix Emissions Set To Run On Boot!";;
				*)fixemissions=0
				  echo "          No FCing Fix On Boot For You!";;
			esac
			sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' $0
			if [ "$0" != "/data/V6_SuperCharger/!FixEmissions.sh" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /data/V6_SuperCharger/!FixEmissions.sh; fi 2>/dev/null
			if [ "$0" != "/system/xbin/fixfc" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /system/xbin/fixfc; fi 2>/dev/null
			if [ "$0" != "/system/etc/init.d/94fixfc" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /system/etc/init.d/94fixfc; fi 2>/dev/null
			if [ -f "/data/V6_SuperCharger/!FixAlignment.sh" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /data/V6_SuperCharger/!FixAlignment.sh; fi
			if [ -f "/system/xbin/fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/xbin/fixalign; fi
			if [ -f "/system/etc/init.d/95fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/etc/init.d/95fixalign; fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				awk 'BEGIN{OFS=FS=","}{$9='$fixemissions',$10='$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
				mv /data/V6_SuperCharger/SuperChargerOptions.tmp /data/V6_SuperCharger/SuperChargerOptions
			fi
			mount -o remount,ro /system 2>/dev/null
			busybox mount -o remount,ro /system 2>/dev/null
			busybox mount -o remount,ro $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null;;
		  *)echo "               No Change For You!";;
	esac
	echo $line
	sleep 1
}
install(){
	if [ ! -f "$1" ]; then
		echo ""
		echo " Installing myself to ${1#*etc}"
		sleep 2
		mount -o remount,rw /system 2>/dev/null
		busybox mount -o remount,rw /system 2>/dev/null
		busybox mount -o remount,rw $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
		dd if=$0 of=$1
		chown 0.0 $1; chmod 777 $1
		mount -o remount,ro /system 2>/dev/null
		busybox mount -o remount,ro /system 2>/dev/null
		busybox mount -o remount,ro $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
	elif [ "`echo $1 | grep xbin`" ]; then
		echo ""
		echo " $1 is already installed..."
		sleep 2
	fi
	if [ "`echo $1 | grep xbin`" ]; then
		echo ""
		echo " To run, type in Terminal: \"su -c ${1##*/}\""
		sleep 2
	fi
}
Fix_Emissions(){
	while [ ! "`ps | grep android | grep -v grep`" ]; do sleep 10; done
	if [ "`echo $0 | grep "init\.d"`" ] && [ "$bootfixemissions" -ne 1 ]; then exit 69
	elif [ "`echo $0 | grep "init\.d"`" ]; then $bootupdelay
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/94fixfc
	fi
	if [ ! "`echo $0 | grep xbin`" ]; then install /system/xbin/fixfc; fi
	LOG_FILE=/data/Ran_FixEmissions.log
	if [ "easyloglulz" ]; then
		echo ""
		echo $line
		echo "   -=Fix Emissions=- script by -=zeppelinrox=-"
		echo $line
		echo ""
		sleep 2
		id=$(id); id=${id#*=}; id=${id%%[\( ]*}
		if [ "$id" != "0" ] && [ "$id" != "root" ]; then
			sleep 1
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
	fi | tee $LOG_FILE
	mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
	START=`busybox date +%s`
	BEGAN=`date`
	TOTAL=`cat /d*/system/packages.xml | grep -c "^<package.*serId"`
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	echo " Start Fix Emissions: $BEGAN" >> $LOG_FILE
	echo "" >> $LOG_FILE
	echo " Setting & Fixing Permissions For..." >> $LOG_FILE
	echo "" >> $LOG_FILE
	busybox sync
	grep "^<package.*serId" /d*/system/packages.xml | while read pkgline; do
		PKGNAME=`echo $pkgline | sed 's%.* name="\(.*\)".*%\1%' | cut -d '"' -f1`
		CODEPATH=`echo $pkgline | sed 's%.* codePath="\(.*\)".*%\1%' |  cut -d '"' -f1`
		DATAPATH=/d*/d*/$PKGNAME
		PKGUID=`echo $pkgline | sed 's%.*serId="\(.*\)".*%\1%' | cut -d '"' -f1`
		PROGRESS=$(($PROGRESS+1))
		PERCENT=$(( $PROGRESS * 100 / $TOTAL ))
		if [ "$PERCENT" -eq "$INCREMENT" ]; then
			INCREMENT=$(( $INCREMENT + 3 ))
			PROGRESS_BAR="$PROGRESS_BAR="
		fi
		clear
		echo ""
		echo -n "                                        >"
		echo -e "\r       $PROGRESS_BAR>"
		echo "       \"Fix Emissions\" by -=zeppelinrox=-"
		echo -n "                                        >"
		echo -e "\r       $PROGRESS_BAR>"
		echo ""
		echo "       Processing Apps - $PERCENT% ($PROGRESS of $TOTAL)"
		echo ""
		echo " Setting & Fixing Permissions For..."
		echo ""
		echo " ...$PKGNAME"
		echo " $PKGNAME ($CODEPATH)" >> $LOG_FILE
		if [ -e "$CODEPATH" ]; then
			APPDIR=`busybox dirname $CODEPATH`
			if [ "$APPDIR" = "/system/app" ] || [ "$APPDIR" = "/vendor/app" ] || [ "$APPDIR" = "/system/framework" ] && [ "`busybox stat -t $CODEPATH | awk '{print $5,$6}'`" != "0 0" ] && [ ! "`busybox stat $CODEPATH | grep "Access.*644"`" ]; then
				chown 0:0 $CODEPATH
				chmod 644 $CODEPATH
			elif [ "$APPDIR" = "/data/app" ] && [ "`busybox stat -t $CODEPATH | awk '{print $5,$6}'`" != "1000 1000" ] && [ ! "`busybox stat $CODEPATH | grep "Access.*644"`" ]; then
				chown 1000:1000 $CODEPATH
				chmod 644 $CODEPATH
			elif [ "$APPDIR" = "/data/app-private" ] && [ "`busybox stat -t $CODEPATH | awk '{print $5,$6}'`" != "1000 $PKGUID" ] && [ ! "`busybox stat $CODEPATH | grep "Access.*640"`" ]; then
				chown 1000:$PKGUID $CODEPATH
				chmod 640 $CODEPATH
			fi
			if [ -d "$DATAPATH" ]; then
				if [ "`busybox stat -t $DATAPATH | awk '{print $5,$6}'`" != "$PKGUID $PKGUID" ] && [ ! "`busybox stat $DATAPATH | grep "Access.*755"`" ]; then
					chown $PKGUID:$PKGUID $DATAPATH
					chmod 755 $DATAPATH
				fi
				DIRS=`busybox find $DATAPATH -mindepth 1 -type d`
				for file in $DIRS; do
					PERM=755
					NEWUID=$PKGUID
					NEWGID=$PKGUID
					FNAME=`busybox basename $file`
					case $FNAME in
							lib)if [ ! "`busybox stat $file | grep "Access.*755"`" ]; then chmod 755 $file; fi
								NEWUID=1000
								NEWGID=1000
								PERM=755;;
		 shared_prefs|databases)if [ ! "`busybox stat $file | grep "Access.*771"`" ]; then chmod 771 $file; fi
								PERM=660;;
						  cache)if [ ! "`busybox stat $file | grep "Access.*771"`" ]; then chmod 771 $file; fi
								PERM=600;;
						  files)if [ ! "`busybox stat $file | grep "Access.*771"`" ]; then chmod 771 $file; fi
								PERM=775;;
							  *)if [ ! "`busybox stat $file | grep "Access.*771"`" ]; then chmod 771 $file; fi
								PERM=771;;
					esac
					if [ "`busybox stat -t $file | awk '{print $5,$6}'`" != "$NEWUID $NEWGID" ]; then chown $NEWUID:$NEWGID $file; fi
					busybox find $file -type f -maxdepth 2 ! -perm $PERM -exec chmod $PERM {} ';'
					busybox find $file -type f -maxdepth 1 ! -user $NEWUID -exec chown $NEWUID {} ';'
					busybox find $file -type f -maxdepth 1 ! -group $NEWGID -exec chown :$NEWGID {} ';'
				done
			fi
		fi | tee -a $LOG_FILE
	done
	busybox sync
	mount -o remount,ro /system 2>/dev/null
	busybox mount -o remount,ro /system 2>/dev/null
	busybox mount -o remount,ro $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
	STOP=`busybox date +%s`
	ENDED=`date`
	RUNTIME=`busybox expr $STOP - $START`
	HOURS=`busybox expr $RUNTIME / 3600`
	REMAINDER=`busybox expr $RUNTIME % 3600`
	MINS=`busybox expr $REMAINDER / 60`
	SECS=`busybox expr $REMAINDER % 60`
	RUNTIME=`busybox printf "%02d:%02d:%02d\n" "$HOURS" "$MINS" "$SECS"`
	echo "" | tee -a $LOG_FILE
	echo $line | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
	echo " FIXED Permissions For ALL $TOTAL Apps..." | tee -a $LOG_FILE
	echo ""| tee -a $LOG_FILE
	sleep 1
	echo "          ...Say Buh Bye To Force Close Errors!"
	echo ""
	echo $line
	echo ""
	sleep 1
	echo "      Start Time: $BEGAN" | tee -a $LOG_FILE
	echo "       Stop Time: $ENDED" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	echo " Completion Time: $RUNTIME" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
	echo " See $LOG_FILE for more details!"
	echo ""
	sleep 1
	echo "         ==============================" | tee -a $LOG_FILE
	echo "          ) Fix Emissions Completed! (" | tee -a $LOG_FILE
	echo "         ==============================" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
}
if [ ! "`ps | grep android | grep -v grep`" ]; then
	exec > /data/BootLog_FixEmissions.log 2>&1
	Fix_Emissions & exit 0
fi
if [ -d "/system/etc/init.d" ]; then Configure; fi
Fix_Emissions
exit 0
