FROM php:latest

RUN apt-get update -yqq
RUN apt-get update && apt-get install -my wget gnupg

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get install git nodejs libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev -yqq

RUN docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache

RUN apt-get install pkg-config libmagickwand-dev wget -y \
    && cd /tmp \
    && wget https://pecl.php.net/get/imagick-3.4.3.tgz \
    && tar xvzf imagick-3.4.3.tgz \
    && cd imagick-3.4.3 \
    && phpize \
    && ./configure \
    && make install \
    && rm -rf /tmp/imagick-3.4.3 \
    && echo extension=imagick.so >> /usr/local/etc/php/conf.d/imagick.ini

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

RUN node -v
RUN npm -v
RUN php -v
RUN composer -v