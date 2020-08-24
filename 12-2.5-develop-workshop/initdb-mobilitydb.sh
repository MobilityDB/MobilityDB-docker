#!/bin/bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'mobilitydb' extension in the mobilitydb database
psql --dbname=mobilitydb <<- 'EOSQL'
	SELECT POSTGIS_VERSION();
	CREATE EXTENSION IF NOT EXISTS mobilitydb;
EOSQL
done