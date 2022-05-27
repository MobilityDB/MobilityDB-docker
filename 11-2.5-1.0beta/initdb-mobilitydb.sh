#!/bin/bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'mobilitydb' extension in the mobilitydb database
echo "Loading MobilityDB extension into mobilitydb"
psql --user="$POSTGRES_USER" --dbname="mobilitydb" <<- 'EOSQL'
	CREATE EXTENSION IF NOT EXISTS mobilitydb CASCADE;
EOSQL
