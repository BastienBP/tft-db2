FROM centos/systemd:latest

LABEL authors="mhamed.bourouh@gmail.com, bastien.brunod@gmail.com"

ARG version=8.4.0
ARG edition=free
ENV INSTALL_DIST=/opt/graphdb

ENV GRAPH_DB_PORT 80

ADD graphdb-free-${version}-dist.zip /tmp
ADD start-graphdb.sh /usr/bin/start-graphdb.sh
ADD graphdb.service /etc/systemd/system

RUN yum install java-1.8.0-openjdk -y && \
    yum install unzip -y && \
    mkdir -p ${INSTALL_DIST} && \
    cd  ${INSTALL_DIST} && \
    unzip /tmp/graphdb-free-${version}-dist.zip -d . && \
    rm /tmp/graphdb-free-${version}-dist.zip && \
    mkdir -p ${INSTALL_DIST}/graphdb-${edition}-${version}/home && \
    sed -ire 's/\r$//g' /usr/bin/start-graphdb.sh && \
    chmod +x /usr/bin/start-graphdb.sh

RUN systemctl enable graphdb

ENV PATH=${INSTALL_DIST}/graphdb-${edition}-${version}/bin:$PATH

CMD ["/usr/sbin/init"]

EXPOSE 80