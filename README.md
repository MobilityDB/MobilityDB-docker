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

Run a container with the latest release image:

```bash
docker run -d --name mobilitydb \
    -e POSTGRES_USER=docker \
    -e POSTGRES_PASSWORD=docker \
    -e POSTGRES_DB=mobilitydb \
    -p 25432:5432 \
    mobilitydb/mobilitydb:latest
```

Connect with `psql` from the host:
```bash
psql -h localhost -p 25432 -d mobilitydb -U docker
```

Or from inside the container:
```bash
docker exec -it mobilitydb psql -U docker -d mobilitydb
```

Environment
-----------------
The image does not set its own defaults. The Quick Start above shows
example values; without `-e` flags, the upstream postgres image's
defaults apply.

* `POSTGRES_USER`: example `docker`, upstream default `postgres`
* `POSTGRES_DB`: example `mobilitydb`, defaults to `POSTGRES_USER`
* `POSTGRES_PASSWORD`: example `docker`, required (no default)

Access from pgAdmin
-----------------
* **Host** `localhost`
* **Port** `25432`
* **Username** value of `POSTGRES_USER` (example `docker`)
* **Password** value of `POSTGRES_PASSWORD` (example `docker`)
