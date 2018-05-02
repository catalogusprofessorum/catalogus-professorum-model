FROM openjdk:8

RUN apt-get update && apt-get -y install maven unzip
ADD https://codeload.github.com/essepuntato/LODE/zip/master /lode/

RUN ls /lode

EXPOSE 8080

RUN cd /lode && unzip master && cd LODE-master
WORKDIR /lode/LODE-master

CMD ["mvn", "jetty:run"]
