#!/bin/bash

sleep 20

#while  ! mysqladmin ping -h localhost -P 3306; 
#do
	#sleep 1;
#done

service php7.3-fpm start

if  ! wp core is-installed --allow-root; 
then

	mkdir -p /var/www/html/cmarouf.42.fr

	cd /var/www/html/cmarouf.42.fr

	wp core download --locale=fr_FR --allow-root

	cp wp-config-sample.php wp-config.php

	sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '$MYSQL_DDB_NAME' );/" wp-config.php
	sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );/" wp-config.php
	sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '$MYSQL_USER' );/" wp-config.php

	chown -R www-data:www-data /var/www/html/cmarouf.42.fr

	wp core install --url=cmarouf.42.fr --title=MyWordpress --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --allow-root
	rm wp-config-sample.php

	echo "OK"
fi

exec "$@"
