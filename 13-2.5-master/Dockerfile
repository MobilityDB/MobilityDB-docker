FROM postgres:13 as builder
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV POSTGIS_VERSION 2.5.5
ENV MOBILITYDB_VERSION master
ENV POSTGRES_DBNAME=mobilitydb
ENV POSTGRES_USER=docker 
ENV POSTGRES_PASSWORD=docker
RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    git \
    libpq-dev \
    liblwgeom-dev \
    libproj-dev \
    libjson-c-dev \
    postgresql-server-dev-11 \
 && wget -O PostGIS.tar.gz "https://github.com/postgis/postgis/archive/${POSTGIS_VERSION}.tar.gz" \
 && mkdir -p /usr/local/src/PostGIS \
 && tar \
        --extract \
        --file PostGIS.tar.gz \
        --directory /usr/local/src/PostGIS \
        --strip-components 1 \
 && rm PostGIS.tar.gz \
 && cd PostGIS \
 && ./autogen.sh \
 && ./configure \
        --with-pcredir="$(pcre-config --prefix)" \
    && make -j$(nproc) \
    && make install

RUN git clone https://github.com/MobilityDB/MobilityDB.git -b master /usr/local/src/MobilityDB
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
	cmake .. && \
	make && \
	make install

RUN rm /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/initdb-mobilitydb.sh
