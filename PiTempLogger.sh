#!/bin/bash
rm -rf logcontainer
rm -rf *.tlog
OUTPUT="logcontainer"
echo -e "temp" >$OUTPUT
#LogFilename=$(<$OUTPUT)
#rm -rf $OUTPUT
#>$OUTPUT
#function removeActiveLog {
	#LogToRemove=$(<$OUTPUT)
	#read -p "Remove Existing Logs? (Y/N) " AnswerRemove
	#if [ "$AnswerRemove" = "Y" ] || [ "$AnswerRemove" = "y" ] ; then
	#rm -rf "$LogToRemove"
	#performLog
	#elif [ "$AnswerRemove" = "N" ] || [ "$AnswerRemove" = "n" ] ; then 
	#performLog
	#else
	#echo -e "Please press Y/y for Yes or N/n for No!!\e"
	#removeActiveLog
	#fi
	
	#}
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
	LogPrefix=$(ls -t $LogFile* | grep tlog | head -1)
	if [ -z "$LogPrefix" ]
		then 
		echo "Log file does not exist."
		mainmenu
	else
		clear
		cat $LogPrefix | less
		mainmenu
	fi
	
	}
function performLog {
	COUNTER=0
	LogFilename=$(<$OUTPUT)
	current_time=$(date "+%Y.%m.%d-%H.%M.%S")
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
	echo -e "$COUNTER \t $myout" >> $LogFilename.$current_time.tlog
	sleep $LogPeriod
	let COUNTER=COUNTER+$LogPeriod
	done
	#return to mainmenu
	mainmenu	
	}
function mainmenu {
	LogFilename=$(<$OUTPUT)
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
