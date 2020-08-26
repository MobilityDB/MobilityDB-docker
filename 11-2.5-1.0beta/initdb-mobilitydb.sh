#!/bin/bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'mobilitydb' db
echo "Creating the mobilitydb database"
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE mobilitydb;
EOSQL

# Create the 'mobilitydb' extension in the mobilitydb database
echo "Loading MobilityDB extension into mobilitydb"
"${psql[@]}" --dbname=mobilitydb <<- 'EOSQL'
	CREATE EXTENSION IF NOT EXISTS mobilitydb CASCADE;
EOSQL
echo "Done!"
