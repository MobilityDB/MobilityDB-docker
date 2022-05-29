FROM mobilitydb/mobilitydb:14-3.2-develop
ENV MOBILITYDB_VERSION BerlinMOD
RUN apt-get update \
 && apt-get install -y \
    wget \
    unzip 

RUN mkdir /BerlinMOD
RUN cd /BerlinMOD && \
    wget -O - https://github.com/MobilityDB/MobilityDB-BerlinMOD/archive/master.tar.gz | tar -xz --strip=2 "MobilityDB-BerlinMOD-master/BerlinMOD"
RUN chmod a+r /BerlinMOD/*