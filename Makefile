PROGRAM="temp"
LOGFILE=/var/log/${PROGRAM}.log

all: program service rotate

program:
	cp ${PROGRAM}.program ${PROGRAM} && chmod +x ${PROGRAM}

service:
	cat ${PROGRAM}.service | sed "s-@NAME@-${PROGRAM}-g" | sed "s-@LOGFILE@-${LOGFILE}-g" > service

rotate:
	cat ${PROGRAM}.rotate | sed "s-@LOGFILE@-${LOGFILE}-g" > rotate

clean:
	rm rotate service temp

install_program: program
	cp ${PROGRAM} /usr/bin/${PROGRAM} && chmod +x /usr/bin/${PROGRAM}

install_service: service
	cp service /etc/init.d/${PROGRAM}

install_rotate: rotate
	cp rotate /etc/logrotate.d/${PROGRAM}

install: install_program install_service install_rotate
	echo "installed!"

uninstall:
	rm /etc/init.d/${PROGRAM} /etc/logrotate.d/${PROGRAM} /usr/bin/${PROGRAM}
