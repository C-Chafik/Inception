FROM debian:buster

RUN     apt-get update; \
        apt-get install -y procps mariadb-client mariadb-server;

COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 3306

ENTRYPOINT ["bash", "/script.sh"]

CMD ["mysqld_safe", "-F"]


#!/bin/bash

#STARTING THE MYSQL SERVICE

if [ -d "/var/lib/mysql/$MYSQL_DDB_NAME" ]
then
        echo "The DDB is already installed"     
else

        mysql_install_db --user=mysql --datadir=/var/lib/mysql

        /usr/share/mysql/mysql.server start

        chown mysql:mysql /usr/sbin/mysqld

        #mysqld_safe &

        # THE '%' ALLOW REMOTE CONNECTION TO ALL HOST, AND LOCALHOST ONLY FROM THE DDB MACHINE

        # We delete the 'anonymous user' so you cant connect with no username
        mysql -e "DELETE FROM mysql.user WHERE User=''"

        mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DDB_NAME;"

        mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

        mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DDB_NAME.* TO '$MYSQL_USER'@'%';"

        # We apply our changement before changing root password, otherwise the script wont be able to exec the remaining commands
        mysql -e "FLUSH PRIVILEGES;"

        # Then we change root password
        mysqladmin -u root password $MYSQL_ROOT_PASSWORD

        #mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
fi

