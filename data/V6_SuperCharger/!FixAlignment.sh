#!/system/bin/sh
#
# Fix Alignment Script (ZipAlign AND Fix Permissions) created by -=zeppelinrox=-
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
# Combines my "ZepAlign" / Wheel Alignment Script (ZipAlign) with my Fix Emissions Script (Fix Permissions).
# Due to the combining of tools and enhancements... it's STUPIDLY FAST!
#
  ###############################
 # Wheel Alignment Information #
###############################
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
  #############################
 # Fix Emissions Information #
#############################
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
# For debugging, delete the # at the beginning of the following 2 lines, and check /data/Log_FixAlign.log file to see what may have fubarred.
# set -x
# exec > /data/Log_FixAlign.log 2>&1
#
line=================================================
cd "${0%/*}" 2>/dev/null
mount -o remount,rw /data 2>/dev/null
busybox mount -o remount,rw /data 2>/dev/null
bootupdelay="sleep 180"
# Next line only applies to the init.d boot script. "bootfixalign=1" means run on boot. Anything else disables it.
bootfixalign=1
Configure(){
	echo ""
	echo " Fix Alignment On Boot..."
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
	echo -n " Status: Fix Alignment "
	if [ "$bootfixalign" -eq 1 ]; then echo "DOES Run On Boot!"
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
	echo " Change Fix Alignment Options?"
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
			echo " Run Fix Alignment on boot?"
			echo ""
			sleep 1
			echo " Note 1: If you say Yes..."
			echo "         Wheel Alignment and Fix Emissions..."
			echo "         ...On Boot are automatically disabled!"
			echo ""
			sleep 1
			echo " Note 2: If you say No..."
			echo "         Wheel Alignment and Fix Emissions..."
			echo "              ...boot options become available!"
			echo ""
			sleep 1
			echo -n " Enter Y for Yes, any key for No: "
			read bootfixalign
			echo ""
			echo $line
			case $bootfixalign in
			  y|Y)fixalign=1; zepalign=0; fixemissions=0
				  echo "        Fix Alignment Set To Run On Boot!";;
				*)fixalign=0
				  echo "   Boot Fix Align Declined... does that rhyme?";;
			esac
			sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' $0
			if [ "$0" != "/data/V6_SuperCharger/!FixAlignment.sh" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /data/V6_SuperCharger/!FixAlignment.sh; fi 2>/dev/null
			if [ "$0" != "/system/xbin/fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/xbin/fixalign; fi 2>/dev/null
			if [ "$0" != "/system/etc/init.d/95fixalign" ]; then sed -i '/^bootfixalign=/s/=.*/='$fixalign'/' /system/etc/init.d/95fixalign; fi 2>/dev/null
			if [ -f "/data/V6_SuperCharger/!WheelAlignment.sh" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /data/V6_SuperCharger/!WheelAlignment.sh; fi
			if [ -f "/system/xbin/zepalign" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /system/xbin/zepalign; fi
			if [ -f "/system/etc/init.d/93zepalign" ]; then sed -i '/^bootzepalign=/s/=.*/='$zepalign'/' /system/etc/init.d/93zepalign; fi
			if [ -f "/data/V6_SuperCharger/!FixEmissions.sh" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /data/V6_SuperCharger/!FixEmissions.sh; fi
			if [ -f "/system/xbin/fixfc" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /system/xbin/fixfc; fi
			if [ -f "/system/etc/init.d/94fixfc" ]; then sed -i '/^bootfixemissions=/s/=.*/='$fixemissions'/' /system/etc/init.d/94fixfc; fi
			if [ -f "/data/V6_SuperCharger/SuperChargerOptions" ]; then
				awk 'BEGIN{OFS=FS=","}{$8='$zepalign',$9='$fixemissions',$10='$fixalign';print}' /data/V6_SuperCharger/SuperChargerOptions > /data/V6_SuperCharger/SuperChargerOptions.tmp
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
Fix_Align(){
	while [ ! "`ps | grep android | grep -v grep`" ]; do sleep 10; done
	if [ "`echo $0 | grep "init\.d"`" ] && [ "$bootfixalign" -ne 1 ]; then exit 69
	elif [ "`echo $0 | grep "init\.d"`" ]; then $bootupdelay
	elif [ -d "/system/etc/init.d" ]; then install /system/etc/init.d/95fixalign
	fi
	if [ ! "`echo $0 | grep xbin`" ]; then install /system/xbin/fixalign; fi
	LOG_FILE=/data/Ran_FixAlign.log
	lastran=/data/!FixAlign_Last_Ran
	if [ "`grep "zipaligned" $LOG_FILE`" ]; then mv $LOG_FILE $lastran; fi 2>/dev/null
	zipalign="yes"
	if [ "easyloglulz" ]; then
		echo ""
		echo $line
		echo "   -=Fix Alignment=- script by -=zeppelinrox=-"
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
			zipalign=
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
			su -c "LD_LIBRARY_PATH=/vendor/lib:/system/lib am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file://$storage/!SuperCharger.html"
			echo ""
			echo $line
			echo ""
			sleep 3
			echo $line
			echo "    So... for now... can ONLY Fix Emissions!"
			echo $line
			echo ""
			sleep 3
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
	TOTAL=`cat /d*/system/packages.xml | grep -c "^<package.*serId"`
	INCREMENT=3
	PROGRESS=0
	PROGRESS_BAR=""
	NEW=0; ALIGNED=0; ALREADY=0; FAILED=0; SKIPPED=0
	echo " Start Fix Alignment: $BEGAN" >> $LOG_FILE
	grep "^<package.*serId" /d*/system/packages.xml > /data/pkgline.tmp
	busybox sync
	while read pkgline; do
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
		echo "       \"Fix Alignment\" by -=zeppelinrox=-"
		echo -n "                                        >"
		echo -e "\r       $PROGRESS_BAR>"
		echo ""
		echo "       Processing Apps - $PERCENT% ($PROGRESS of $TOTAL)"
		echo "" | tee -a $LOG_FILE
		echo " Fix Aligning $PKGNAME..." | tee -a $LOG_FILE
		echo ""
		if [ -e "$CODEPATH" ]; then
			if [ ! -f "$lastran" ] || [ "$CODEPATH" -nt "$lastran" ] && [ "$zipalign" ]; then NEW=$(($NEW+1))
				if [ "$(busybox basename $CODEPATH)" = "framework-res.apk" ] || [ "$(busybox basename $CODEPATH)" = "SystemUI.apk" ] || [ "$(busybox basename $CODEPATH)" = "com.htc.resources.apk" ]; then
					echo " NOT ZipAligning (Problematic) $CODEPATH..." | tee -a $LOG_FILE
					SKIPPED=$(($SKIPPED+1))
					skippedapp=`echo "$skippedapp, $(busybox basename $CODEPATH)" | sed 's/^, //'`
				else
					zipalign -c 4 $CODEPATH
					ZIPCHECK=$?
					if [ "$ZIPCHECK" -eq 1 ]; then
						echo " ZipAligning $CODEPATH..." | tee -a $LOG_FILE
						zipalign -f 4 $CODEPATH /cache/$(busybox basename $CODEPATH)
						rc="$?"
						if [ "$rc" -eq 0 ]; then
							if [ -e "/cache/$(busybox basename $CODEPATH)" ]; then
								busybox cp -f -p /cache/$(busybox basename $CODEPATH) $CODEPATH | tee -a $LOG_FILE
								ALIGNED=$(($ALIGNED+1))
							else
								echo " ZipAligning $CODEPATH... Failed (No Output File!)" | tee -a $LOG_FILE
								FAILED=$(($FAILED+1))
								failedapp=`echo "$failedapp, $(busybox basename $CODEPATH)" | sed 's/^, //'`
							fi
						else echo " ZipAligning $CODEPATH... Failed (rc: $rc!)" | tee -a $LOG_FILE
							FAILED=$(($FAILED+1))
							failedapp=`echo "$failedapp, $(busybox basename $CODEPATH)" | sed 's/^, //'`
						fi
						if [ -e "/cache/$(busybox basename $CODEPATH)" ]; then busybox rm /cache/$(busybox basename $CODEPATH); fi
					else
						echo " ZipAlign already completed on $CODEPATH" | tee -a $LOG_FILE
						ALREADY=$(($ALREADY+1))
					fi
				fi
			fi
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
			echo " Fixed Permissions..." | tee -a $LOG_FILE
		fi
	done < /data/pkgline.tmp
	busybox sync
	rm /data/pkgline.tmp
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
	if [ "$zipalign" ]; then
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
		echo $line | tee -a $LOG_FILE
	fi
	echo "" | tee -a $LOG_FILE
	sleep 1
	echo " FIXED Permissions For ALL $TOTAL Apps..." | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
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
	echo "          ) Fix Alignment Completed! (" | tee -a $LOG_FILE
	echo "         ==============================" | tee -a $LOG_FILE
	echo "" | tee -a $LOG_FILE
	sleep 1
}
if [ ! "`ps | grep android | grep -v grep`" ]; then
	exec > /data/BootLog_FixAlign.log 2>&1
	Fix_Align & exit 0
fi
if [ -d "/system/etc/init.d" ]; then Configure; fi
Fix_Align
exit 0
