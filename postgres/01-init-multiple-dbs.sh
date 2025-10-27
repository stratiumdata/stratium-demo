#!/bin/bash
set -e
set -u

# Create stratium user (shared by both databases)
echo "  Creating shared user 'stratium'"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER stratium WITH PASSWORD 'stratium';
EOSQL

# Create stratium_pap database
echo "  Creating database 'stratium_pap'"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE stratium_pap;
    GRANT ALL PRIVILEGES ON DATABASE stratium_pap TO stratium;
    \c stratium_pap
    GRANT ALL ON SCHEMA public TO stratium;
EOSQL

# Create stratium_keymanager database
echo "  Creating database 'stratium_keymanager'"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE stratium_keymanager;
    GRANT ALL PRIVILEGES ON DATABASE stratium_keymanager TO stratium;
    \c stratium_keymanager
    GRANT ALL ON SCHEMA public TO stratium;
EOSQL

echo "Multiple databases created successfully"
