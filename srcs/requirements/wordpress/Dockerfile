FROM debian:buster

RUN 	apt-get -y update; \
 	apt-get -y upgrade; \
	apt-get -y install php php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc \ 
			    php7.3-cli php7.3-zip php7.3-soap php7.3-imap wget unzip mariadb-client;

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf 

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

ENTRYPOINT ["bash", "/script.sh"]

CMD ["php-fpm7.3", "-F"]
