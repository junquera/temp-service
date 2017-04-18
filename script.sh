#!/bin/bash
LOGFILE='/var/log/temp-service.log'
log(){
    echo "$(date +%T): $*" >> $LOGFILE
}

while sleep 5;
do
    temp = $(sensors | awk 'match($0, "\\+([0-9][0-9]\\.[0-9]).C",ary){ a[NR]=ary[1]} END{for(x in a){res += a[x]; count++} print res/count}' 2>/dev/null)
    log $temp
done
