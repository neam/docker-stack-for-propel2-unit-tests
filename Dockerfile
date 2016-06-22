# Dockerfile for running Propel2 Unit Tests
# ===============================================================

FROM neam/debian-php:fpm-5.6.20-hhvm-3.13.1

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-06-22 13:24

# Enable locales, editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
        locales \
        curl \
        wget \
        less \
        nano \
        vim

# Install PHP extensions available via apt-get (required for PHP-FPM, but can also be useful to HHVM since default configurations for the extensions are incorporated in the docker image)
RUN apt-get install -y -q \
        php5-intl \
        php5-mysql \
        php5-sqlite \
        php5-pgsql

# ====
# Install/setup enough to be able to successfully run the unit tests
# ====

# Setup config variables
RUN echo 'memory_limit = 512M' >> /etc/php5/fpm/conf.d/app.ini
RUN echo 'date.timezone = Europe/Berlin' >> /etc/php5/fpm/conf.d/app.ini
RUN echo 'memory_limit = 512M' >> /etc/hhvm/php.ini
RUN echo 'date.timezone = Europe/Berlin' >> /etc/hhvm/php.ini

# Database clients
RUN apt-get install -y -q \
        mysql-client

# Composer (so that we use a clean composer install)
RUN curl -sS https://getcomposer.org/installer | php && \
        mv /composer.phar /usr/local/bin/composer

# An UTF-8 locale must be installed and enabled for some tests to pass
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen
RUN dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Set env vars for database access
ENV MYSQL_DB_HOSTNAME mysql
ENV MYSQL_DB_USER root
ENV MYSQL_DB_PW local-mysql-pass

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add user to run tests as (needs to be an unprivileged user)
RUN useradd -m -p "abc" propel
