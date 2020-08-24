FROM postgis/postgis:12-2.5
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV MOBILITYDB_VERSION develop
ENV POSTGRES_DBNAME=mobilitydb
ENV POSTGRES_USER=docker 
ENV POSTGRES_PASSWORD=docker
RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    libpq-dev \
    liblwgeom-dev \
    libproj-dev \
    libjson-c-dev \
    libgsl-dev \
    libgslcblas0 \
    postgresql-server-dev-12
RUN git clone https://github.com/MobilityDB/MobilityDB.git -b develop /usr/local/src/MobilityDB
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
    cmake .. && \
    make && \
    make install

COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/1_initdb-mobilitydb.sh
RUN chmod +x /docker-entrypoint-initdb.d/1_initdb-mobilitydb.sh
RUN mkdir /BerlinMOD
RUN cd /BerlinMOD && \
    wget -O - https://github.com/MobilityDB/MobilityDB-BerlinMOD/archive/master.tar.gz | tar -xz --strip=2 "MobilityDB-BerlinMOD-master/BerlinMOD"
RUN chmod a+r /BerlinMOD/*
