FROM ubuntu:latest

WORKDIR /var/www/vit

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    git \
    apache2 \
    php7.3 \
    libapache2-mod-php7.3 \
    php7.3-cli \
    php7.3-json \
    php7.3-curl \
    php7.3-fpm \
    php7.3-gd \
    php7.3-ldap \
    php-mbstring \
    php7.3-mysql \
    php7.3-sqlite3 \
    php7.3-zip \
    php7.3-mbstring \
    php7.3-mysql \
    php7.3-zip \
    php7.3-intl \
    php7.3-xml \
    php7.3-bcmath\
    php-intl \
    php-imagick \
    openssh-client \
    openssh-server \
    graphicsmagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    locales \
    cron\
    mc \
    wget \
    imagemagick \
    python3 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pip3 install --upgrade setuptools
RUN pip3 install awscli --upgrade --user

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite expires
RUN a2enmod proxy_fcgi setenvif
RUN a2enconf php7.3-fpm


RUN mkdir /var/www/vit/storage
RUN chmod 775 /var/www/vit/storage

# Add new non-root user to container
RUN groupadd -r vit && useradd --no-log-init  -r -g vit vit

# Copy apache2 config to run project under apache2 server
COPY ./docker/vhost-config.conf /etc/apache2/sites-available/vhost-config.conf
RUN a2dissite 000-default.conf
RUN a2ensite vhost-config.conf

COPY ./docker/run.sh /vit/
RUN chmod 777 /vit/run.sh

RUN mkdir /var/www/vit/app
COPY ./app/* /var/www/vit/app

# Run custom file sh to run apache2 and set right permissions for project
RUN find /var/www/vit    -type f -exec chmod 664 {} \;
RUN chown -R 1000:www-data /var/www/vit

# Expose port
EXPOSE 80

ENTRYPOINT ["/vit/run.sh"]

