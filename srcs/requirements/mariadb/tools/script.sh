#!/bin/bash

#STARTING THE MYSQL SERVICE
service mysql start

# THE MYSQL INSTALLATION SCRIPT REQUIRE A PROMPT, AND IS JUST A REDIRECTION OF ANOTHER BASH SCRIPT
# SO WE WILL SETUP THE DATA BASE MANUALLY IN PRETTY MUCH THE SAME WAY OF THE SCRIPT

# MAKE SURE YOU CANNOT CONNECT TO THE DDB WIHTOUT A PASSWORD
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root'"

# DISALLOW REMOTE LOGIN FOR ROOT
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1')"

# REMOVE ANONYMOUS USER
mysql -e "DELETE FROM mysql.user WHERE User=''"

# REMOVING THE TEST DATABASE
mysql -e "DROP DATABASE IF EXISTS test"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'"

# RELOAD PRIVILEGE TO TAKE CHANGE EFFECT
mysql -e "FLUSH PRIVILEGES"

# RUN THE DDB AS A DAEMON
mysqld
