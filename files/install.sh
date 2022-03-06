#!/usr/bin/env bash

set -ex

###
## install missing tools
###

apt-get update -q --fix-missing
apt-get -yq upgrade

apt-get -yq install -y --no-install-recommends \
    zlib1g-dev \
    libicu-dev \
    g++ \
    libxml2-dev

###
## php extensions
###
docker-php-ext-install -j$(nproc) \
    intl \
    soap \
    opcache \
    mysqli
docker-php-ext-enable \
    intl \
    soap \
    opcache \
    mysqli

###
## CleanUp
###

set +e

apt-get -y clean
apt-get -y autoclean
apt-get -y autoremove
rm -r /var/lib/apt/lists/*

rm -rf "${APACHE_WORKDIR}/.git"
