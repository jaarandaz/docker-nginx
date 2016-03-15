FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install nginx supervisor
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

# Avoid auto-daemonizaiton
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/var/www", "/etc/nginx/sites-available", "/etc/nginx/sites-enabled"]

# Workdir
RUN mkdir -p /var/www
WORKDIR /var/www

CMD ["/usr/bin/supervisord"]

EXPOSE 80 443
