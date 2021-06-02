FROM postgres:13

# Configuration Parameters
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV POSTGIS_VERSION 2.5
ENV MOBILITYDB_VERSION master
ENV MOBILITYDB_GIT_HASH bce48f2ec6dffda1d19dd7fd8de191b2a4866d8b
ENV POSTGRES_DBNAME=mobilitydb
ENV POSTGRES_USER=docker 
ENV POSTGRES_PASSWORD=docker

# Fix the Release file expired problem
RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until

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
RUN cd /usr/local/src/ \
  && git clone https://github.com/MobilityDB/MobilityDB.git \
  && cd MobilityDB \
  && git checkout ${MOBILITYDB_GIT_HASH} \
  && mkdir build \
  && cd build && \
	cmake .. && \
	make -j$(nproc) && \
	make install

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/mobilitydb.sh
RUN chmod +x /docker-entrypoint-initdb.d/mobilitydb.sh
