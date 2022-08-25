FROM php:7.0-apache
WORKDIR /var/www/html
COPY index.php /var/www/html/
EXPOSE 80 8080