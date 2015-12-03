#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99
# Interpolated to apply to PostgreSQL

echo '* Working around permission errors locally by making sure that "postgres" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" /var/lib/postgresql)
echo '-- Setting postgres user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID postgres || true
TARGET_GID=$(stat -c "%g" /var/lib/postgresql)
echo '-- Setting postgres group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID postgres || true
echo
echo '* Starting PostgreSQL'
#chown -R postgres:root /var/run/pgsqld/
/entrypoint.sh pgsqld --user=postgres --console
