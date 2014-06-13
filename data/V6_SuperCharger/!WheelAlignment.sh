#!/system/bin/sh
#
# "ZepAlign" / Wheel Alignment Script (ZipAlign) created by -=zeppelinrox=-
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
# ZipAligns all data and system apks (apps) that have not yet been ZipAligned.
# ZipAlign optimizes all your apps, resulting in less RAM comsumption and a faster device! ;^]
#
# Option 1. By default, this will check and/or zipalign only apks which were recently added and may need it.
# Option 2. Or, when asked, you can force it to zipalign all apks! (Obviously, this takes a bit longer).
#
# The code is HIGHLY optimized... so it's REALLY FAST!
#
# Get full stats from the log file!
#
# Tweaks & Enhancements by zeppelinrox...
#      - Added BRAINS: By default, it will only check apks that were added since last run (ie. newer than the log file!)
#      - Added support for /vendor/app (POST-ICS)
#      - Added support for /mnt/asec
#      - Added support for more data directories ie. dbdata, datadata, etc.
#      - Added debugging
#      - Tweaked interface... just a bit ;^]
#
# Props: Automatic ZipAlign by Wes Garner (original script)
#        oknowton for the change from MD5 to zipalign -c 4
#
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Log_ZepAlign.log file to see what may have fubarred.
# set -x
# exec > /data/Log_ZepAlign.log 2>&1
#
line=================================================
cd "${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
bootupdelay="sleep 180"
# Next line only applies to the init.d boot script. "bootzepalign=1" means run on boot. Anything else disables it.
bootzepalign=0
Configure(){
	echo ""
	echo " Wheel Alignment On Boot..."
	echo " =========================="
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
	echo -n " Status: Wheel Alignment "
	if [ "$bootzepalign" -eq 1 ]; then echo "DOES Run On Boot!"
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
	echo " Change Wheel Alignment Options?"
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
			echo " Run Wheel Alignment on boot?"
			echo ""
			sleep 1
			echo " Note: If you say Yes, Fix Alignment On Boot..."
			echo "      ...gets disabled (avoids overlapping mods)"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootzepalign
			echo ""
			echo $line
			case $bootzepalign in
			  y|Y)zepalign=1; fixalign=0
				  echo "       Wheel Alignment Set To Run On Boot!";;
				*)zepalign=0
				  echo "     Boot Align Declined... does that rhyme?";;
			esac
			sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' $0
			if [ "$0" != "/data/V6_SuperCharger/!WheelAlignment.sh" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /data/V6_SuperCharger/!WheelAlignment.sh; fi 2>/dev/null
			if [ "$0" != "/system/xbin/zepalign" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /system/xbin/zepalign; fi 2>/dev/null
			if [ "$0" != "/system/etc/init.d/93zepalign" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /system/etc/init.d/93zepalign; fi 2>/dev/null
			if [ -f "/data/V6_SuperCharger/!FixAlignment.sh" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /data/V6_SuperCharger/!FixAlignment.sh; fi
			if [ -f "/system/xbin/fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/xbin/fixalign; fi
			if [ -f "/system/etc/init.d/95fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/etc/init.d/95fixalign; fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				awk 'BEGIN{OFS=FS=","}{$8='$zepalign',$10='$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
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
ZepAlign(){
	while [ ! "`ps | grep android | grep -v grep`" ]; do sleep 10; done
	if [ "`echo $0 | grep "init\.d"`" ] && [ "$bootzepalign" -ne 1 ]; then exit 69
	elif [ "`echo $0 | grep "init\.d"`" ]; then $bootupdelay
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/93zepalign
	fi
	if [ ! "`echo $0 | grep xbin`" ]; then install /system/xbin/zepalign; fi
	LOG_FILE=/data/Ran_ZepAlign.log
	lastran=/data/!ZepAlign_Last_Ran
	mv $LOG_FILE $lastran 2>/dev/null
	if [ "easyloglulz" ]; then
		echo ""
		echo $line
		echo "  -=Wheel Alignment=- script by -=zeppelinrox=-"
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
		elif [ ! "`which zipalign`" ]; then
			sleep 1
			echo " Doh... zipalign binary was NOT found..."
			echo ""
			sleep 3
			echo $line
			echo "                    ...No ZepAligning For You!!"
			echo $line
			echo ""
			sleep 3
			echo " Load the XDA SuperCharger thread..."
			echo ""
			sleep 3
			echo "   ...and install The SuperCharger Starter Kit!"
			echo ""
			echo $line
			echo ""
			sleep 3
			su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file:///storage/sdcard0/!SuperCharger.html"
			echo ""
			echo $line
			echo ""
			sleep 3
			exit 69
		elif [ -f "$lastran" ]; then
			echo " ZipAlign ALL Apps or only recently installed?"
			echo ""
			sleep 1
			echo -n " Enter (A)LL, any key for recently added: "
			stty -icanon min 0 time 200
			read how
			stty sane
			if [ ! "$how" ]; then echo ""; fi
			echo ""
			case $how in
				a|A)rm $lastran;;
				  *);;
			esac
			echo $line
			echo ""
			sleep 1
		fi
	fi | tee $LOG_FILE
	mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw /system 2>/dev/null
	busybox mount -o remount,rw $(busybox mount | awk '$3=="/system"{print $1,$3}') 2>/dev/null
	START=`busybox date +%s`
	BEGAN=`date`
	TOTAL=$((`ls /d*/*/*.apk | wc -l`+`ls /system/*/*.apk | wc -l`+`ls /vendor/*/*.apk | wc -l`+`ls /mnt/asec/*/*.apk | wc -l`)) 2>/dev/null
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	NEW=0; ALIGNED=0; ALREADY=0; FAILED=0; SKIPPED=0
	echo " Start Wheel Alignment ( \"ZepAlign\" ): $BEGAN" >> $LOG_FILE
	echo "" >> $LOG_FILE
	busybox sync
	for apk in /d*/*/*.apk /system/*/*.apk /vendor/*/*.apk /mnt/asec/*/*.apk; do
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
		echo "       Wheel Alignment by -=zeppelinrox=-"
		echo -n "                                        >"
		echo -e "\r       $PROGRESS_BAR>"
		echo ""
		echo "       Processing APKs - $PERCENT% ($PROGRESS of $TOTAL)"
		echo ""
		if [ ! -f "$lastran" ] || [ "$apk" -nt "$lastran" ] && [ -f "$apk" ]; then NEW=$(($NEW+1))
			if [ "$(busybox basename $apk)" = "framework-res.apk" ] || [ "$(busybox basename $apk)" = "SystemUI.apk" ] || [ "$(busybox basename $apk)" = "com.htc.resources.apk" ]; then
				echo " NOT ZipAligning (Problematic) $apk..." | tee -a $LOG_FILE
				SKIPPED=$(($SKIPPED+1))
				skippedapp=`echo "$skippedapp, $(busybox basename $apk)" | sed 's/^, //'`
			else
				zipalign -c 4 $apk
				ZIPCHECK=$?
				if [ "$ZIPCHECK" -eq 1 ]; then
					echo " ZipAligning $apk..." | tee -a $LOG_FILE
					zipalign -f 4 $apk /cache/$(busybox basename $apk)
					rc="$?"
					if [ "$rc" -eq 0 ]; then
						if [ -e "/cache/$(busybox basename $apk)" ]; then
							busybox cp -f -p /cache/$(busybox basename $apk) $apk | tee -a $LOG_FILE
							ALIGNED=$(($ALIGNED+1))
						else
							echo " ZipAligning $apk... Failed (No Output File!)" | tee -a $LOG_FILE
							FAILED=$(($FAILED+1))
							failedapp=`echo "$failedapp, $(busybox basename $apk)" | sed 's/^, //'`
						fi
					else echo " ZipAligning $apk... Failed (rc: $rc!)" | tee -a $LOG_FILE
						FAILED=$(($FAILED+1))
						failedapp=`echo "$failedapp, $(busybox basename $apk)" | sed 's/^, //'`
					fi
					if [ -e "/cache/$(busybox basename $apk)" ]; then busybox rm /cache/$(busybox basename $apk); fi
				else
					echo " ZipAlign already completed on $apk" | tee -a $LOG_FILE
					ALREADY=$(($ALREADY+1))
				fi
			fi
		fi
	done
	busybox sync
	rm $lastran 2>/dev/null
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
	echo " Done \"ZepAligning\" ALL data and system APKs..." | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
	echo " $NEW	Apps were checked (added since last run)" | tee -a $LOG_FILE
	echo " $ALIGNED	Apps were zipaligned" | tee -a $LOG_FILE
	echo " $ALREADY	Apps were already zipaligned" | tee -a $LOG_FILE
	echo " $FAILED	Apps were NOT zipaligned due to error" | tee -a $LOG_FILE
	if [ "$failedapp" ]; then echo "	($failedapp)" | tee -a $LOG_FILE; fi
	echo " $SKIPPED	Problematic Apps were skipped" | tee -a $LOG_FILE
	if [ "$skippedapp" ]; then echo "	($skippedapp)" | tee -a $LOG_FILE; fi
	echo "" | tee -a $LOG_FILE
	echo " $TOTAL	Apps were processed!" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
	echo "                ...Say Hello To Optimized Apps!"
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
	echo "        ================================" | tee -a $LOG_FILE
	echo "         ) Wheel Alignment Completed! (" | tee -a $LOG_FILE
	echo "        ================================" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
}
if [ ! "`ps | grep android | grep -v grep`" ]; then
	exec > /data/BootLog_ZepAlign.log 2>&1
	ZepAlign & exit 0
fi
if [ -d "/system/etc/init.d" ]; then Configure; fi
ZepAlign
exit 0
