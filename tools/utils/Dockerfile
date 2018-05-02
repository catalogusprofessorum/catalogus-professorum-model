FROM ubuntu:16.04
MAINTAINER Thomas Riechert "https://aksw.org/ThomasRiechert"

RUN apt-get update && apt-get -y upgrade 

#Install Raputils
RUN apt-get -y install libraptor2-dev

#RUN rm -rf /var/lib/apt/lists/* 
RUN mkdir /home/work/
WORKDIR /home/work

CMD ["tail", "-f", "/dev/stdout"]
