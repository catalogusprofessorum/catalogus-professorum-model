FROM openjdk:8

RUN mkdir /var/www && mkdir /var/www/html
WORKDIR /var/www/

COPY startup.sh /usr/local/bin/
RUN echo "\ntail -f /dev/stdout" >> /usr/local/bin/startup.sh
RUN chmod a+x /usr/local/bin/startup.sh

CMD ["startup.sh"]




