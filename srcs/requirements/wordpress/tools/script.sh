#!/bin/bash

sleep 20

#while  ! mysqladmin ping -h localhost -P 3306; 
#do
	#sleep 1;
#done

service php7.3-fpm start

if  ! wp core is-installed --path=/var/www/html/cmarouf.42.fr --allow-root; 
then

	mkdir -p /var/www/html/cmarouf.42.fr

	cd /var/www/html/cmarouf.42.fr

	wp core download --allow-root

	wp config create --dbname=$MYSQL_DDB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --locale=fr_FR --allow-root

	wp core install --url=cmarouf.42.fr --title=MyWordpress --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

	echo "OK"
fi

service php7.3-fpm stop

exec "$@"
