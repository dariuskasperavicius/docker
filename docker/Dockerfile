FROM php:8.1-fpm-alpine

WORKDIR /srv/test.com

RUN docker-php-ext-install pdo pdo_mysql

RUN apk add --update linux-headers

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug \
  && apk del pcre-dev ${PHPIZE_DEPS}

RUN apk update && apk add bash

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
    && pecl install redis pcov \
    && docker-php-ext-enable redis pcov \
    && apk del pcre-dev ${PHPIZE_DEPS}
