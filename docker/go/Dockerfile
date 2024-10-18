# syntax=docker/dockerfile:1

ARG GO_VERSION
ARG DISTRO_VERSION

FROM golang:${GO_VERSION}-${DISTRO_VERSION}

RUN apt update && \
    # Git & Utilities
    apt install -y --no-install-recommends git unzip

# Install Hugo
ARG HUGO_VERSION
RUN wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar -xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && mv hugo /usr/local/bin/ \
    && rm hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

# Confirm Hugo was installed
RUN hugo version

# Dart Sass
RUN curl -L https://github.com/sass/dart-sass/releases/download/1.80.2/dart-sass-1.80.2-linux-x64.tar.gz -o /tmp/dart-sass.tar.gz \
    && tar -xzf /tmp/dart-sass.tar.gz -C /usr/local/bin --strip-components=1 \
    && rm /tmp/dart-sass.tar.gz

# Confirm Dart Sass was installed
RUN sass --version

# Create user & set same user id as local user
ARG USER_UID

RUN useradd --create-home --uid ${USER_UID} worker

USER worker

WORKDIR /repositories
