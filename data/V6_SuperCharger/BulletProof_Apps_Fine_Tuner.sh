#!/system/bin/sh
#
# BulletProof Apps Fine Tuner created by -=zeppelinrox=-
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
# Use this file to "Fine Tune" App Priorities to your liking!
#
# The possible values of oom_adj range from -17 to 15.
# Newer kernels use oom_score_adj instead with values from -1000 to 1000.
# The higher the score, more likely the associated process is to be killed by OOM-killer.
# Basically, the conversion to the new system is oldstyle*1000/17 and the decimal is truncated.
# So if something had an ADJ of 6, it would now be 6*1000/17=352.94118... which truncates down to 352.
#
# A niceness (effects CPU Time) of -20 is the highest priority and 19 is the lowest priority.
# A higher priority process will get a larger chunk of the CPU time than a lower priority process.
# 0 is usually the default niceness for processes and is inherited from its parent process.
#
# In this script, by default, all apps have priorities applied as follows:
# echo -17 > /proc/`pgrep *com.app.name*`/oom_adj
# echo -1000 > /proc/`pgrep *com.app.name*`/oom_score_adj (one or the other will apply lol)
# renice -10 `pgrep *com.app.name*`
# The renice of -10 should be sufficient to keep it snappy but not interfere with other apps that you're using ;^]
#
# At the opposite end, if you wanted something to get killed off easily, you can change it to:
# echo 15 > /proc/`pgrep *com.app.name*`/oom_adj
# echo 1000 > /proc/`pgrep *com.app.name*`/oom_score_adj (for newer kernels)
# renice 19 `pgrep *com.app.name*`
#
# Typically, an app's (Secondary Servers) values (when SuperCharged) are:
# echo 6 > /proc/`pgrep *com.app.name*`/oom_adj
# echo 352 > /proc/`pgrep *com.app.name*`/oom_score_adj (for newer kernels)
# renice 0 `pgrep *com.app.name*`
#
line=================================================;
echo $line;
echo "     -=BulletProof Apps Fine Tuner Module=-";
echo $line;
echo "";
echo " Find this in /data/V6_SuperCharger folder...";
echo "";
echo "                       ...read its comments...";
echo "";
echo "             ...and \"Fine Tune\" App Priorities!";
echo "";
echo $line;
echo "";
id=$(id); id=${id#*=}; id=${id%%[\( ]*};
if [ "$id" != "0" ] && [ "$id" != "root" ]; then
	echo " You are NOT running this script as root...";
	echo "";
	echo $line;
	echo "                      ...No SuperUser For You!!";
	echo $line;
	echo "";
	echo "     ...Please Run as Root and try again...";
	echo "";
	echo $line;
	echo "";
	exit 69;
fi

