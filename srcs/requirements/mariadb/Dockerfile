FROM alpine:3.15.0

# DEPENDANCE

RUN 	apk update; \
 	apk add --no-cache openrc; \
	apk add --no-cache mariadb; \
	apk add --no-cache mariadb-client;

# PORTS
EXPOSE 3306


COPY tools/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["sh", "/script.sh"]
