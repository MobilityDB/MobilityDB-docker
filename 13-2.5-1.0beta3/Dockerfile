FROM postgres:13

# Configuration Parameters
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV POSTGIS_VERSION 2.5
ENV MOBILITYDB_VERSION 1.0-beta3
ENV POSTGRES_DBNAME=mobilitydb
ENV POSTGRES_USER=docker 
ENV POSTGRES_PASSWORD=docker

# Install Prerequisites 
RUN apt-get update \
 && apt-get install -y \
    build-essential \
    cmake \
    git \
    libproj-dev \    
    g++ \
    wget \
    autoconf \
    autotools-dev \
    libgeos-dev \
    libpq-dev \
    liblwgeom-dev \
    libproj-dev \
    libjson-c-dev \
    protobuf-c-compiler \
    xsltproc \
    libgsl-dev \
    libgslcblas0 \  
    postgresql-server-dev-13 \
  && apt-cache showpkg postgresql-13-postgis-$POSTGIS_VERSION \
  && apt-get install -y --no-install-recommends \
       postgresql-13-postgis-$POSTGIS_VERSION \
       postgresql-13-postgis-$POSTGIS_VERSION-scripts \
  && rm -rf /var/lib/apt/lists/* 

# Install MobilityDB 
RUN wget -O MobilityDB.tar.gz "https://github.com/MobilityDB/MobilityDB/archive/v${MOBILITYDB_VERSION}.tar.gz" \
 && mkdir -p /usr/local/src/MobilityDB \
 && tar \
        --extract \
        --file MobilityDB.tar.gz \
        --directory /usr/local/src/MobilityDB \
        --strip-components 1 \
 && rm MobilityDB.tar.gz
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
	cmake .. && \
	make -j$(nproc) && \
	make install

COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/initdb-mobilitydb.sh