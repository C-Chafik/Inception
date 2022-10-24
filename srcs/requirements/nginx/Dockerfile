FROM debian:buster
RUN apt-get -y update && apt-get -y install nginx
COPY conf /etc/nginx/sites-available/default
EXPOSE 443/tcp
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
#CMD ["cat", "/etc/nginx/sites-available/default"]
