#!/bin/bash
start() {
    /usr/local/bin/temp-monitor.sh &
    echo $! > /var/run/temp-monitor.pid
}

stop() {
    if [ ! -f /var/run/temp-monitor.pid ]; 
    then
        echo "$0 isn't running"
        exit 1
    fi
    kill -9 $(cat /var/run/temp-monitor.pid)        
}

status {
    if [ -f /var/run/temp-monitor.pid ];
    then
        echo "$0 service is running"
    else
        echo "$0 service isn't running"
        exit 1
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        $0 stop
        $0 start
        ;;
    status)
        status
        ;;
     *)
         echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0
