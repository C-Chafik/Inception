FROM debian:buster

RUN 	apt-get update; \
	apt-get install -y mariadb-client mariadb-server; 

EXPOSE 3306

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["bash", "/script.sh"]

EXPOSE 3306

CMD ["mysqld_safe"]
