# VERSION 1.0
# AUTHOR: Matthieu "Puckel_" Roisil
# DOCKER HUB: https://hub.docker.com/u/puckel/
# DESCRIPTION: Simple Debian image for azkaban-webserver based on official java:8
# BUILD: docker build --rm -t puckel/azkaban-webserver .
# SOURCE: https://github.com/puckel/docker-azkaban

FROM java:8
MAINTAINER Puckel_

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
ENV INITRD No

ENV AZK_VERSION 2.5.0
ENV MYSQL_JDBC_VERSION 5.1.35

WORKDIR /root

RUN apt-get update -yqq \
    && apt-get install -yqq \
    curl \
    netcat \
    mysql-client \
    && curl -sLk https://s3.amazonaws.com/azkaban2/azkaban2/$AZK_VERSION/azkaban-web-server-$AZK_VERSION.tar.gz| tar xz \
    && curl -sLk http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_JDBC_VERSION.tar.gz| tar xz \
    && mv mysql-connector-java-$MYSQL_JDBC_VERSION/mysql-connector-java-$MYSQL_JDBC_VERSION-bin.jar azkaban-web-$AZK_VERSION/extlib/ \
    && rm -rf mysql-connector-java-$MYSQL_JDBC_VERSION \
    && mkdir azkaban-web-$AZK_VERSION/logs/ \
    # Work around to run container as a daemon
    && sed -i "s/&//" azkaban-web-$AZK_VERSION/bin/azkaban-web-start.sh \
    && apt-get clean \
    && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
    /usr/share/man \
    /usr/share/doc \
    /usr/share/doc-base

ADD keystore azkaban-web-$AZK_VERSION/keystore
ADD conf/azkaban.properties azkaban-web-$AZK_VERSION/conf/azkaban.properties

# Azkaban web server port
EXPOSE 8443

# Define default workdir
WORKDIR /root/azkaban-web-$AZK_VERSION
ADD script/run.sh run.sh
RUN chmod +x run.sh

CMD ["./run.sh"]
