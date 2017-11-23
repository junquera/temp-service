PROGRAM="temp"
LOGFILE=/var/log/${PROGRAM}.log
SYSD=0

all: program service rotate systemd

program:
	cp ${PROGRAM}.program ${PROGRAM} && chmod +x ${PROGRAM}

service:
	cat ${PROGRAM}.service | sed "s-@NAME@-${PROGRAM}-g" | sed "s-@LOGFILE@-${LOGFILE}-g" > service && chmod +x service

systemd:
	cat ${PROGRAM}.systemd | sed "s-@NAME@-${PROGRAM}-g" > systemd

rotate:
	cat ${PROGRAM}.rotate | sed "s-@LOGFILE@-${LOGFILE}-g" > rotate

clean:
	rm rotate service temp systemd

install_program: program
	cp ${PROGRAM} /usr/bin/${PROGRAM}

# Add system startup: https://askubuntu.com/questions/351879/how-to-create-a-service-on-ubuntu-upstart
install_service: service
	cp service /etc/init.d/${PROGRAM}

install_systemd: systemd
	if [ ${SYSD} ]; then cp systemd /etc/systemd/system/${PROGRAM}.service; else ln -s /dev/null /etc/systemd/system/${PROGRAM}.service; fi && systemctl unmask ${PROGRAM}.service

install_rotate: rotate
	cp rotate /etc/logrotate.d/${PROGRAM}

install: install_program install_service install_rotate install_systemd
	service ${PROGRAM} start && echo "Installed!"

uninstall:
	rm /etc/init.d/${PROGRAM} /etc/logrotate.d/${PROGRAM} /usr/bin/${PROGRAM} /etc/systemd/system/${PROGRAM}.service
