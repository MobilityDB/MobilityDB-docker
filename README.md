MobilityDB Docker
==================================

<img src="https://raw.githubusercontent.com/MobilityDB/MobilityDB/master/doc/images/mobilitydb-logo.svg" width="200" alt="MobilityDB Logo" />

[MobilityDB](https://github.com/MobilityDB/MobilityDB) is an open source software program that adds support for temporal and spatio-temporal objects to the [PostgreSQL](https://www.postgresql.org/) object-relational database and its spatial extension [PostGIS](http://postgis.net/).

This repository builds and publishes Docker images that ship MobilityDB on top of the official [PostgreSQL](https://github.com/docker-library/postgres) + [PostGIS](https://github.com/postgis/docker-postgis) images. All environment variables, mount points, and entrypoint behavior of the upstream `postgis/postgis` images apply here as well.

Requirements
-----------------
* [Docker Engine](https://docs.docker.com/install/) version **17.05** or newer
* [Docker Compose](https://docs.docker.com/compose/install/) version **1.20.0** or newer

Tags
-----------------

Image names follow the pattern `mobilitydb/mobilitydb:<PG>-<PostGIS>-<MobilityDB>`. Each combination has a corresponding directory in this repository containing its `Dockerfile`.

**MobilityDB 1.3 (latest stable):**
* `mobilitydb/mobilitydb:14-3.5-1.3`
* `mobilitydb/mobilitydb:15-3.5-1.3`
* `mobilitydb/mobilitydb:16-3.5-1.3`
* `mobilitydb/mobilitydb:17-3.5-1.3`
* `mobilitydb/mobilitydb:18-3.6-1.3`
* `mobilitydb/mobilitydb:latest` — alias for `18-3.6-1.3`

**MobilityDB 1.2:**
* `mobilitydb/mobilitydb:13-3.5-1.2`
* `mobilitydb/mobilitydb:14-3.5-1.2`
* `mobilitydb/mobilitydb:15-3.5-1.2`
* `mobilitydb/mobilitydb:16-3.5-1.2`
* `mobilitydb/mobilitydb:17-3.5-1.2`

**MobilityDB development (`master` branch):**
* `mobilitydb/mobilitydb:16-3.5-master`
* `mobilitydb/mobilitydb:17-3.5-master`
* `mobilitydb/mobilitydb:18-3.6-master`

The `master` images are rebuilt automatically on every push to `master` in the [MobilityDB](https://github.com/MobilityDB/MobilityDB) repository. The release-tagged images (`-1.2`, `-1.3`) are rebuilt on a weekly schedule from the corresponding `stable-*` branch.

Installation
-----------------
Pre-built images are available on [Docker Hub](https://hub.docker.com/r/mobilitydb/mobilitydb):

```bash
docker pull mobilitydb/mobilitydb:[TAG]
```

To build an image locally from this repository, pass the tag's directory as the build context:

```bash
docker build -t mobilitydb/mobilitydb:18-3.6-1.3 'https://github.com/MobilityDB/MobilityDB-docker.git#master:18-3.6-1.3'
```

Quick Start
-----------------

* Clone or download this repository
* Go inside the directory for the desired tag, e.g. `cd 18-3.6-1.3`
* Run `docker-compose up -d`

Connect directly with `psql` if you have the PostgreSQL client tool installed:
```bash
psql -h localhost -p 25432 -d mobilitydb -U docker
```

Or connect from inside the container:
```bash
docker ps                              # find the container name
docker exec -it <container_name> bash
psql -d mobilitydb -U docker
```

Environment
-----------------
* `POSTGRES_DB` — default `mobilitydb`
* `POSTGRES_USER` — default `docker`
* `POSTGRES_PASSWORD` — default `docker`

Access from pgAdmin
-----------------
* **Host** `localhost`
* **Port** `25432`
* **Username** value of `POSTGRES_USER` (default `docker`)
* **Password** value of `POSTGRES_PASSWORD` (default `docker`)
