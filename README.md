# Description
This is a simple Bash script to log the temperature of your Raspberry PI
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
### Tested on:
*This script has been tested on a __RPI3__ running __RetroPie__ 4.4.38-v7+ #938 SMP armv71 GNU/Linux
