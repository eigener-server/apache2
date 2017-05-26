FROM php:7.0.19-apache

# Install gd iconv und mcrypt für captcha erstellung mit PHP (nur GD wird aktuell benötigt)
RUN apt-get update && \
    apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*

# php.ini source: https://github.com/php/php-src/blob/master/php.ini-production
COPY php.ini /usr/local/etc/php/
