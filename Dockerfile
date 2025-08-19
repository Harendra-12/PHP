FROM php:8.2-apache-alpine

WORKDIR /var/www/html

COPY . .

RUN rm -rf tests docs README.md \
    && chown -R www-data:www-data /var/www/html

EXPOSE 80
