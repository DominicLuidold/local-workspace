# syntax=docker/dockerfile:1

ARG PHP_VERSION
ARG DISTRO_VERSION

FROM php:${PHP_VERSION}-${DISTRO_VERSION}

ARG USER_UID

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN apt update && \
    # Git
    apt install -y --no-install-recommends git && \
    # PHP extensions
    install-php-extensions @composer intl xdebug-^3@stable zip-^1@stable && \
    # Symfony CLI
    curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash && \
    apt install -y --no-install-recommends symfony-cli && \
    # Create user & set same user id as local user
    useradd --create-home --uid ${USER_UID} worker && \
    # Cleanup
    docker-php-source delete && \
    rm -rf /tmp/* && rm -rf /var/lib/apt/lists/*

COPY ./docker/php/files/usr/local/etc/php/conf.d/zz-development.ini /usr/local/etc/php/conf.d/zz-development.ini

USER worker

WORKDIR /repositories
