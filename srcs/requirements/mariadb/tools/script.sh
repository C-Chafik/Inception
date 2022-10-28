#!/bin/bash

#STARTING THE MYSQL SERVICE
service mysql start

mysql_install_db --user=mysql --datadir=/var/lib/mysql
chown mysql:mysql /run/mysqld

# THE '%' ALLOW REMOTE CONNECTION TO ALL HOST, AND LOCALHOST ONLY FROM THE DDB MACHINE

# We delete the 'anonymous user' so you cant connect with no username
mysql -e "DELETE FROM mysql.user WHERE User=''"

mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DDB_NAME;"

mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DDB_NAME.* TO '$MYSQL_USER'@'%';"

# We apply our changement before changing root password, otherwise the script wont be able to exec the remaining commands
mysql -e "FLUSH PRIVILEGES;"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
