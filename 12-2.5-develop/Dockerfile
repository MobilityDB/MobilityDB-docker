FROM postgis/postgis:12-2.5
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
ENV MOBILITYDB_VERSION develop
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
    libgslcblas0 \
    postgresql-server-dev-12

# Install MobilityDB     
RUN git clone https://github.com/MobilityDB/MobilityDB.git -b develop /usr/local/src/MobilityDB
RUN mkdir /usr/local/src/MobilityDB/build
RUN cd /usr/local/src/MobilityDB/build && \
	cmake .. && \
	make && \
	make install

RUN rm /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./initdb-mobilitydb.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/initdb-mobilitydb.sh