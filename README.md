MobilityDB Docker
==================================

<img src="https://raw.githubusercontent.com/MobilityDB/MobilityDB/master/doc/images/mobilitydb-logo.svg" width="200" alt="MobilityDB Logo" />

[MobilityDB](https://github.com/MobilityDB/MobilityDB) is an open source software program that adds support for temporal and spatio-temporal objects to the [PostgreSQL](https://www.postgresql.org/) object-relational database and its spatial extension [PostGIS](http://postgis.net/).

This is a repository to hold various Docker images for MobilityDB releases.

Quick Start
-----------------

* Clone or download this repository
* Go inside of the required version
* Run this command `docker-compose up -d`

Environment
-----------------
* `POSTGRES_USER` the default value is **postgres**
* `POSTGRES_PASSWORD` the default value is **root**
* `PGADMIN_PORT` the default value is **5432**

Usage
-----------------

The images are based on the official [Postgres](https://github.com/docker-library/postgres) and [Postgis](https://github.com/postgis/docker-postgis) docker images so the documentation for the images also applies here, including the environment variables one can set, extensibility, etc.

