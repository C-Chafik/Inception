FROM debian:buster

# DEPENDANCE

RUN 	apt-get -y update; \
	apt-get -y install mysql-server; \
	apt-get -y install mariadb-server;
# PORTS
EXPOSE 3306

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh 

ENTRYPOINT ["/script.sh"]
