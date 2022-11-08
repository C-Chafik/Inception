FROM debian:buster

RUN 	apt-get update; \
	apt-get install -y procps mariadb-client mariadb-server; 

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["bash", "/script.sh"]

CMD ["mysqld"]
