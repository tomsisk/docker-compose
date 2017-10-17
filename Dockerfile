FROM php:7.1-fpm
RUN apt-get update && apt-get install -y \
        libxml2-dev \
        libpq-dev \
    && docker-php-ext-install -j$(nproc) soap \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) pdo pdo_pgsql \
    && docker-php-ext-enable soap bcmath pdo pdo_pgsql
