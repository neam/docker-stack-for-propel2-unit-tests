# Docker Stack for running Propel2 Unit Tests #

[Propel2]() is an open-source Object-Relational Mapping (ORM) for PHP 5.4.

This repository makes it straight-forward to run Propel2 Unit Tests locally and is aimed for those that wish to contribute to the Propel2 codebase. 

## Getting Started

First, read [http://propelorm.org/documentation/cookbook/working-with-test-suite.html]().

Then check out the source code to both this repo and Propel2, in side-by-side directories:

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
```

Then, inside the docker shell:
```
composer install --prefer-source
```

## Running Unit Tests (Should be run inside the docker shell)

Agnostic tests:
```
tests/bin/phpunit.agnostic.sh
```

MySQL tests:
```
export DB_HOSTNAME=$MYSQL_DB_HOSTNAME
export DB_USER=$MYSQL_DB_USER
export DB_PW=$MYSQL_DB_PW 
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

## Troubleshooting

In case all database tests mysteriously start failing all at once, try forcing a regeneration of the fixtures:

```
rm /propel2/tests/Fixtures/fixtures_built
```

Then re-run the tests.

To interact with MySQL, either use the following command from inside the docker shell:

```
mysql -h$MYSQL_DB_HOSTNAME -u$MYSQL_DB_USER -p$MYSQL_DB_PW
```

Or, connect from the outside using the following details:

IP:
```
docker-machine ip default
```

Port:
```
docker-compose port mysql 3306 | sed 's/[0-9.]*://'
```

## License ##

See the `LICENSE` file.
