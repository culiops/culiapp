ARG PHP_VERSION=8.1
ARG COMPOSER_VERSION=2.0

FROM composer:${COMPOSER_VERSION}
FROM php:${PHP_VERSION}-cli

RUN apt-get update && \
    apt-get install -y autoconf pkg-config libssl-dev supervisor git libzip-dev zlib1g-dev && \
    docker-php-ext-install pdo pdo_mysql && docker-php-ext-enable pdo pdo_mysql && \
    pecl install redis && docker-php-ext-enable redis && \
    docker-php-ext-install -j$(nproc) zip && \
    rm -rf /tmp/pear

COPY --from=composer /usr/bin/composer /usr/local/bin/composer

COPY docker.entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8000
WORKDIR /code
ENTRYPOINT ["/entrypoint.sh"]
