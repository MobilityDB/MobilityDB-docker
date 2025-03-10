# Build stage
ARG POSTGRES_VERSION=16
ARG POSTGIS_VERSION=3.5

FROM postgis/postgis:${POSTGRES_VERSION}-${POSTGIS_VERSION} AS builder

# Set build arguments
ARG MOBILITYDB_TAG=stable-1.2

# Install build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        wget \
        libproj-dev \
        libjson-c-dev \
        libgsl-dev \
        libgeos-dev \
        postgresql-server-dev-${PG_MAJOR} \
    && rm -rf /var/lib/apt/lists/*

# Download and extract MobilityDB source
WORKDIR /usr/local/src
RUN wget -O MobilityDB.tar.gz "https://github.com/MobilityDB/MobilityDB/archive/${MOBILITYDB_TAG}.tar.gz" \
    && mkdir -p MobilityDB \
    && tar \
        --extract \
        --file MobilityDB.tar.gz \
        --directory MobilityDB \
        --strip-components 1 \
    && rm MobilityDB.tar.gz

# Build MobilityDB
WORKDIR /usr/local/src/MobilityDB
RUN mkdir -p build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release \
             -DNPOINT=on -DPOSE=on .. \
    && make -j$(nproc) \
    && make install

# Prepare initialization script
RUN cp docker/initdb-mobilitydb.sh /tmp/11_mobilitydb.sh

# Final stage
FROM postgis/postgis:${POSTGRES_VERSION}-${POSTGIS_VERSION}

# Configuration Parameters
LABEL maintainer="MobilityDB Project - https://github.com/MobilityDB/MobilityDB"
LABEL org.opencontainers.image.description="MobilityDB - An open source geospatial trajectory data management & analysis platform"
LABEL org.opencontainers.image.source="https://github.com/MobilityDB/MobilityDB"

# Install runtime dependencies only
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libproj-dev \
        libjson-c-dev \
        libgsl-dev \
        libgeos-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy MobilityDB installed files from builder
COPY --from=builder /usr/share/postgresql/${PG_MAJOR}/extension/mobilitydb* /usr/share/postgresql/${PG_MAJOR}/extension/
COPY --from=builder /usr/lib/postgresql/${PG_MAJOR}/lib/libMobilityDB* /usr/lib/postgresql/${PG_MAJOR}/lib/
COPY --from=builder /tmp/11_mobilitydb.sh /docker-entrypoint-initdb.d/11_mobilitydb.sh
