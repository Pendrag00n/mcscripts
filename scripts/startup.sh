#!/bin/bash
# Script intended to be ran on startup (using cron) after power loss or reboot

# SUDO check
if [ "$EUID" -ne 0 ]; then
  echo ""
  echo -e "\e[1;31m EXECUTE THIS SCRIPT AS ROOT! \e[0m"
  echo ""
exit
fi

# Check if a screen with name 'mcserver' is running
#if runuser - mcuser -c 'screen -list' | grep -q "mcserver"; then
#	echo "Screen is already running! Exiting..."
#	exit 0
#fi

runuser - mcuser -c "screen -dmS mcserver && screen -S mcserver -X stuff 'cd /home/mcuser/serverfolder/ && bash /home/mcuser/serverfolder/run.sh\r'"

if [[ $? -eq 0 ]]; then
        echo "Server started successfully!"
else
        echo "Server failed to start!"
        exit 1
fi

sleep 3
PID=$(pgrep java)
echo "$PID" > /home/mcuser/serverfolder/scripts/lastpid.txt
renice -n -18 -p "$PID"

if [[ $? -eq 0 && -n "$PID" ]]; then
	echo "Reniced succesfully"
	exit 0
else
	echo "Failed to renice!"
	exit 1
fi
