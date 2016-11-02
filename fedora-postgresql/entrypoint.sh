#!/bin/bash
set -e

# If no conf file, then must be initial startup, create one.
if [[ ! -f /var/lib/pgsql/data/postgresql.conf ]]; then
    /usr/bin/initdb -D /var/lib/pgsql/data/
    echo "host    all             all             0.0.0.0/0               trust" >> /var/lib/pgsql/data/pg_hba.conf
    echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf
    echo "port = 5432" >> /var/lib/pgsql/data/postgresql.conf
fi

# startup postgresql
/usr/bin/postgres --config-file=/var/lib/pgsql/data/postgresql.conf -D /var/lib/pgsql/data
