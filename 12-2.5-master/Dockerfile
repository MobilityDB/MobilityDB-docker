FROM postgis/postgis:12-2.5
LABEL maintainer="MobilityDB Project - https://github.com/ULB-CoDE-WIT/MobilityDB"
ENV MOBILITYDB_VERSION master
ENV POSTGRES_DBNAME=mobilitydb
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=test
RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    git \
    libpq-dev \
    liblwgeom-dev \
    libproj-dev \
    libjson-c-dev \
    libgsl-dev \
    libgslcblas0 \
    postgresql-server-dev-12
RUN git clone https://github.com/ULB-CoDE-WIT/MobilityDB.git -b master /usr/local/src/MobilityDB
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
	cmake .. && \
	make && \
	make install