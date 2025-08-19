# Test
FROM php:8.2-apache
WORKDIR /var/www/html
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
