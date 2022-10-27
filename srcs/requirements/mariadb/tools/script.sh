#!/bin/bash

#STARTING THE MYSQL SERVICE
service mysql start

mysql_install_db


# THE MYSQL INSTALLATION SCRIPT REQUIRE A PROMPT, AND IS JUST A REDIRECTION OF ANOTHER BASH SCRIPT
# SO WE WILL SETUP THE DATA BASE MANUALLY IN PRETTY MUCH THE SAME WAY OF THE SCRIPT

# THE '%' ALLOW REMOTE CONNECTION WHILE LOCALHOST DOESN'T

mysql -e "DELETE FORM mysql.user WHERE User=''"

mysql -e "CREATE DATABASE $MYSQL_DDB_NAME;"

mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DDB_NAME TO '$MYSQL_USER'@'%';"

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

mysql -e "FLUSH PRIVILEGES;"
