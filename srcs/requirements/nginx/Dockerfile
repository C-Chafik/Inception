FROM debian:buster

# INSTALL NGINX AND OPENSSL FOR HTTPS CERTIFICAT

RUN 	apt-get -y update; \ 
	apt-get -y install nginx; \
 	apt-get -y install openssl; \
	echo "<h1>Welcome to cmarouf site </h1>" > /var/www/html/index.html; \
	openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=cmarouf.42.fr" -addext "subjectAltName=DNS:cmarouf.42.fr" -newkey rsa:2048 -keyout /etc/ssl/private/cmarouf.42.fr.key -out /etc/ssl/certs/cmarouf.42.fr.crt;	

# IMPORTING NGINX CONFIG

COPY conf /etc/nginx/sites-available/default

# LISTEN TO DEFAULT AND HTTPS PORT

EXPOSE 80
EXPOSE 443

# RUN THE SERVER
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]

