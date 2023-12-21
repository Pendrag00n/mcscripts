#!/bin/bash
# Script that warns players of a reboot/shutdown. Finally runs a backup of the serverfolder 

# SUDO check
if [ "$EUID" -ne 0 ]; then
  echo ""
  echo -e "\e[1;31m EXECUTE THIS SCRIPT AS ROOT! \e[0m"
  echo ""
exit
fi

# Warn about closing time
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 5 minutos^M'"
sleep 240
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 1 minuto^M'"
sleep 50
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 10 segundos^M'"
sleep 5
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 5 segundos^M'"
sleep 1
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 4 segundos^M'"
sleep 1
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 3 segundos^M'"
sleep 1
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 2 segundos^M'"
sleep 1
runuser - mcuser -c "screen -S mcserver -X stuff 'say Cerrando el servidor en 1 segundo^M'"
sleep 1
runuser - mcuser -c "screen -S mcserver -X stuff 'stop^M'"

# Wait until 'pgrep java' returns empty
while true; do
    if ! pgrep java; then
        echo "Server closed. Starting backup"
        break
    fi
    sleep 10
done

# Run packup (https://github.com/Pendrag00n/Packup)
bash /home/mcuser/serverfolder/scripts/packup.sh
exit 0
