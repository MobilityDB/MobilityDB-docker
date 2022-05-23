FROM postgis/postgis:11-2.5
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV MOBILITYDB_VERSION master
ENV MOBILITYDB_GIT_HASH d81c9d3e32369831452310563a4f1e1b79e7c2f8
ENV POSTGRES_DB=mobilitydb
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
    libpq-dev \
    liblwgeom-dev \
    libproj-dev \
    libjson-c-dev \
    libgsl-dev \
    postgresql-server-dev-11

# Install MobilityDB      
RUN cd /usr/local/src/ \
    && git clone https://github.com/MobilityDB/MobilityDB.git \
    && cd MobilityDB \
    && git checkout ${MOBILITYDB_GIT_HASH} \
    && mkdir build \
    && cd build && \
	cmake .. && \
	make && \
	make install

RUN rm /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/initdb-mobilitydb.sh
