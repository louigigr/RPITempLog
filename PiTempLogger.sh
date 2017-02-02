#!/bin/bash
rm -rf logcontainer
rm -rf *.tlog
OUTPUT="logcontainer"
echo -e "temp" >$OUTPUT
#LogFilename=$(<$OUTPUT)
#rm -rf $OUTPUT
#>$OUTPUT
function cleanQuit {
	read -p "Keep Logs? " keepLogs
	if [ "$keepLogs" = "Y" ] || [ "$keepLogs" = "y" ] ; then
	rm -rf logcontainer
	elif [ "$keepLogs" = "N" ] || [ "$keepLogs" = "n" ] ; then 
	rm -rf *.tlog
	rm -rf logcontainer
	else
	echo -e "Please press Y/y for Yes or N/n for No!!\e"
	cleanQuit
	fi
	}
function setLogFilename {
	
	dialog --title "Input Box" --backtitle "Temperature Logger" \
	--inputbox "Enter log filename " 8 60 2>$OUTPUT
	mainmenu
	}
function viewLog {
	LogFile=$(<$OUTPUT)
	cat $LogFile.tlog | less
	mainmenu
	}
function performLog {	
	COUNTER=0
	ShowTime=0
	LogFilename=$(<$OUTPUT)
	read -p "Set Log Total Time: " LogTotalTime
	read -p "Set Log Period: " LogPeriod
	#for i in {16..21} {21..16} ;
	#do echo -en "\e[38;5;${i}mStart Logging every $LogPeriod for $LogTotalTime ...\e[0m" ; done ; echo
	echo -e "Start Logging every $LogPeriod seconds for $LogTotalTime seconds ..."
	while [  $COUNTER -lt $LogTotalTime ]; do
	#echo Measurement $COUNTER is:
	myout=$(vcgencmd measure_temp | cut -d'=' -f2 | cut -d"'" -f1)
	#echo -e "Current Time is"
	echo -e "Temperature at \e[104m$COUNTER\e[49m seconds is \e[41m$myout\xC2\xB0C\e[49m "
	echo -e "Waiting $LogPeriod second(s)"
	echo -e "$COUNTER \t $myout" >> $LogFilename.tlog
	sleep $LogPeriod
	let COUNTER=COUNTER+$LogPeriod
	done
	#return to mainmenu
	mainmenu	
	}
function mainmenu {
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=5
	BACKTITLE="Temperature Logger"
	TITLE="Logger Main Menu"
	MENU="Choose one of the following options:"
	
	OPTIONS=(1 "Run Temperature Log"
	         2 "Select Log Filename"
	         3 "View Log"
	         4 "Exit Logger")
	
	CHOICE=$(dialog --clear \
	                --backtitle "$BACKTITLE" \
	                --title "$TITLE" \
	                --menu "$MENU" \
	                $HEIGHT $WIDTH $CHOICE_HEIGHT \
	                "${OPTIONS[@]}" \
	                2>&1 >/dev/tty)
	
	clear
	case $CHOICE in
	        1)
	            performLog
	            ;;
	        2)
	            setLogFilename
	            ;;
	        3)
	            viewLog
	            ;;
            4)
				cleanQuit
				;;
	esac
	}

mainmenu
