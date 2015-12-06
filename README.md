# Docker Stack for running Propel2 Unit Tests #

[Propel2]() is an open-source Object-Relational Mapping (ORM) for PHP 5.4.

This repository makes it straight-forward to run Propel2 Unit Tests locally and is aimed for those that wish to contribute to the Propel2 codebase. 

## Getting Started

Check out the source code to both this repo and Propel2, in side-by-side directories:

```
git clone https://github.com/neam/docker-stack-for-propel2-unit-tests.git
git clone https://github.com/propelorm/Propel2.git
```

Install [Docker Toolbox](https://www.docker.com/docker-toolbox).

To get a cross-platform Propel2 unit test environment with the required dependencies installed, start the docker unit test shell from within this repository's root folder:

```
cd docker-stack-for-propel2-unit-tests
eval "$(docker-machine env default)"
docker-compose run shell /bin/bash
composer install --prefer-source
```

## Running Unit Tests (Should be run inside the docker shell)

Agnostic tests:
```
tests/bin/phpunit.agnostic.sh
```

MySQL tests:
```
export DB_HOSTNAME=mysql
export DB_USER=root
export DB_PW=local-mysql-pass 
tests/bin/setup.mysql.sh
tests/bin/phpunit.mysql.sh
```

SQLite tests:
```
tests/bin/setup.sqlite.sh
tests/bin/phpunit.sqlite.sh
```

## TODO

Support for PostgreSQL is not complete. Pull requests welcome. 

PostgreSQL tests:
```
export DB_HOSTNAME=pgsql
export DB_USER=root
export DB_PW=local-pgsql-pass 
tests/bin/setup.pgsql.sh
tests/bin/phpunit.pgsql.sh
```

## License ##

See the `LICENSE` file.
