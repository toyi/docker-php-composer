FROM php:8.0.3-alpine

RUN apk add --no-cache bash git zlib-dev icu-dev libpng-dev openssl-dev g++ git unzip gettext-dev libxml2-dev libzip-dev
RUN which ssh-agent || (apk add -qq openssh-client)
RUN docker-php-ext-install gd exif gettext soap zip bcmath pdo_mysql
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php && php -r "unlink('composer-setup.php');" && mv composer.phar /usr/local/bin/composer
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv && export LD_PRELOAD=/usr/lib/preloadable_libiconv.so php
