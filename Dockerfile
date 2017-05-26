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
    apt-get install -y --no-install-recommends libmagickwand-dev && \
    pecl install imagick && docker-php-ext-enable imagick && \
    docker-php-ext-install json && \ 
    docker-php-ext-install ctype && \ 
    docker-php-ext-install dom && \ 
    docker-php-ext-install posix && \ 
    docker-php-ext-install zip && \
    apt install -y --no-install-recommends libcurl3-dev && \
    docker-php-ext-install curl && \
    apt install -y --no-install-recommends libicu-dev && \
    docker-php-ext-install intl && \
    docker-php-ext-install fileinfo && \
    docker-php-ext-install bz2 && \
    apt install -y --no-install-recommends libldap2-dev && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-install ldap && \
    docker-php-ext-install xml && \
    docker-php-ext-install mbstring && \
    pecl install APCu && \
    docker-php-ext-enable apcu && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    docker-php-ext-enable opcache && \
    apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/*

# php.ini source: https://github.com/php/php-src/blob/master/php.ini-production
COPY php.ini /usr/local/etc/php/
