FROM composer as composer
FROM php:8.0.3-alpine

RUN apk add --no-cache git bash unzip zlib-dev icu-dev libpng-dev openssl-dev g++ gettext-dev libxml2-dev libzip-dev openssh-client
RUN docker-php-ext-install gd exif gettext soap zip bcmath pdo_mysql xml
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv && export LD_PRELOAD=/usr/lib/preloadable_libiconv.so php
COPY --from=composer /usr/bin/composer /usr/bin/composer
WORKDIR /
