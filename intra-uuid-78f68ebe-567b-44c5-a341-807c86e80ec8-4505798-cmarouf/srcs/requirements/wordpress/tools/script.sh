#!/bin/bash

until mysql -s --host=mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "\c"
do
	echo "Waiting for $MYSQL_DDB_NAME to be running...."
	sleep 1;
done

echo "$MYSQL_DDB_NAME is up !"

service php7.3-fpm start

if  ! wp core is-installed --path=/var/www/html/cmarouf.42.fr --allow-root; 
then

	mkdir -p /var/www/html/cmarouf.42.fr

	cd /var/www/html/cmarouf.42.fr

	wp core download --allow-root

	echo "Trying to connect to $DB_HOST with $MYSQL_USER and $MYSQL_PASSWORD"

	wp config create --dbname=$MYSQL_DDB_NAME --dbhost=$DB_HOST --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --locale=fr_FR --allow-root

	wp core install --url=cmarouf.42.fr --title=MyWordpress --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root

	echo "OK"

	# It is indeed risky to setup wordpress as root, we we will set all of what wordpress installed as the user www-data so that the rserver is more secure

	chown -R www-data:www-data /var/www/html/
fi

service php7.3-fpm stop

exec "$@"
