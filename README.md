# Description
This is a simple Bash script to log the temperature of your Raspberry PI. You can install it from source or you can download and execute the latest binary.
### v0.1-lw
[Download Latest Version](https://github.com/louigigr/RPITempLog/releases/download/v0.1-lw/PiTempLogger.x)
#### Binary Execution
In order to execute the latest binary you need to make the file executable
```
chmod +x PiTempLogger.x
```
Binary execution needs __superuser__ rights
```
sudo ./PiTempLogger.x
```
### Dependencies
It should run on any system that has *vcgencmd* and *dialog* installed

__vcgencmd__ is already present on Raspberry Pi 3

__To install dialog type:__
```
sudo apt-get install dialog
```
# Installation

### Clone the repository using git:

```
git clone https://github.com/louigigr/RPITempLog.git
```
```

cd RPITempLog
```
```

chmod +x PiTempLogger.sh
```
### Run the script:
```
./PiTempLogger.sh
```
# Usage
Upon running the script you will be presented with a menu. This is the place where all the main functions are listed.

1. Run Temperature log: When selected a default log output file is created named *temp.tlog*. If you have changed the name of the output log by selecting option 2 from the menu then the log will be output accordingly. You will be asked to enter the *Log total time*, which is the total time the logger will run. After that you will be asked to enter the *Log Period* which is the interval between each log.
2. Select the log filename: Using this option you can enter a specific name for your log. The prefix *.tlog* is automatically added. The output file is a tab seperated table which you can use as you wish. Changing output filenames during sessions can help you monitor your PI's temperature in different conditions(e.g. different emulators)
3. View Log: With this option you can view the latest log. Using option 2 to change the output log basicaly switches between logs if they exist. So by entering a name for an existing log in option 2 will display that log when selecting option 3.
4. Exit Logger: Quits the logger. It will ask you to keep the logs or delete them.

### Tested on:
*This script has been tested on a __RPI3__ running __RetroPie__ 4.4.38-v7+ #938 SMP armv71 GNU/Linux
### License
Released under the [GPLv3](https://raw.githubusercontent.com/louigigr/RPITempLog/master/LICENSE) license .

