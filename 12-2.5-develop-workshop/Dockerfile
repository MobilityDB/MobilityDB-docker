FROM mobilitydb/mobilitydb:12-2.5-develop
ENV MOBILITYDB_VERSION Workshop
RUN apt-get update \
 && apt-get install -y \
    wget \
    unzip 

RUN mkdir /workshopData
RUN cd /workshopData && \
    wget https://raw.githubusercontent.com/MobilityDB/MobilityDB-workshop/master/data/gtfs_data.zip && \
    wget https://raw.githubusercontent.com/MobilityDB/MobilityDB-workshop/master/data/ais_data.zip && \
    unzip ais_data.zip -d ais_data && \
    unzip gtfs_data.zip -d gtfs_data && \
    rm -f ais_data.zip gtfs_data.zip
RUN chmod a+r /workshopData/*
