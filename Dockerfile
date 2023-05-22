FROM php:8.1-fpm as php81

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

RUN docker-php-ext-install pdo pdo_mysql

#WORKDIR /var/www

#COPY --chown=www-data . .

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

COPY ./composer.* ./

RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

COPY . .

RUN composer dump-autoload --optimize
#RUN php artisan optimize
#
#RUN chmod -R 775 ./storage
#
#RUN chmod -R 775 ./bootstrap/cache

#ENTRYPOINT [ "Docker/entrypoint.sh" ]
