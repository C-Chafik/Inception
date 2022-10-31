#!/bin/bash


mkdir -p /var/www/html

cd /var/www/html

wget https://wordpress.org/latest.zip

unzip latest.zip

rm latest.zip

mv wordpress cmarouf.42.fr

cd cmarouf.42.fr

cp wp-config-sample.php wp-config.php

	sed -i "s/define( 'DB_NAME', '.*' );/define( 'DB_NAME', '$MYSQL_DDB_NAME' );/" wp-config.php
	sed -i "s/define( 'DB_PASSWORD', '.*' );/define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );/" wp-config.php
	sed -i "s/define( 'DB_USER', '.*' );/define( 'DB_USER', '$MYSQL_USER' );/" wp-config.php

chown -R www-data:www-data /var/www/html/cmarouf.42.fr

service php7.3-fpm start
