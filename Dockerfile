FROM debian:jessie

MAINTAINER "Mike Farrow" <contact@mikefarrow.co.uk>

ENV WEB_ROOT /data/public

WORKDIR /tmp

# Install Nginx
RUN apt-get update -y && \
    apt-get install -y nginx

# Apply Nginx configuration
ADD config/nginx.conf /opt/etc/nginx.conf
ADD config/vhost /etc/nginx/sites-available/vhost
RUN ln -s /etc/nginx/sites-available/vhost /etc/nginx/sites-enabled/vhost && \
    rm /etc/nginx/sites-enabled/default

# Nginx startup script
ADD config/nginx-start.sh /opt/bin/nginx-start.sh
RUN chmod u=rwx /opt/bin/nginx-start.sh

# Redirect logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# PORTS
EXPOSE 80

WORKDIR /opt/bin
ENTRYPOINT ["/opt/bin/nginx-start.sh"]
