# Dockerfile for running Propel2 Unit Tests
# ===============================================================

FROM neam/debian-php:fpm-5.6.14-hhvm-3.10.1

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2015-12-03 12:55

# Enable editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
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
# Install/setup enough to be able to run the unit tests
# ====

# Setup config variables
RUN echo 'memory_limit = 512M' >> /etc/php5/fpm/conf.d/app.ini
RUN echo 'date.timezone = Europe/Berlin' >> /etc/php5/fpm/conf.d/app.ini
RUN echo 'memory_limit = 512M' >> /etc/hhvm/php.ini
RUN echo 'date.timezone = Europe/Berlin' >> /etc/hhvm/php.ini

# Database clients
RUN apt-get install -y -q \
        mysql-client

# PHP Unit
RUN wget https://phar.phpunit.de/phpunit.phar && \
        chmod +x phpunit.phar && \
        mv phpunit.phar /usr/local/bin/phpunit

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
