FROM fedora

MAINTAINER Ken Johnson <gigawatts51@gmail.com>

ENV container="docker"
ENV PKGURL=http://dl.ubnt.com/unifi/5.4.16/UniFi.unix.zip
ENV RPMURL=https://copr-be.cloud.fedoraproject.org/results/alsadi/dumb-init/fedora-24-x86_64/00448255-dumb-init/dumb-init-1.1.3-9.fc24.x86_64.rpm

RUN dnf clean all

# TODO: Use the yum repo so we don't have to link the RPM directly
#RUN dnf copr enable alsadi/dumb-init
#RUN curl -sSL https://copr.fedorainfracloud.org/coprs/alsadi/dumb-init/repo/fedora-25 -o /etc/yum.repo.d/alsadi-dumb-init.repo
#RUN dnf install -y dumb-init

RUN dnf install -y ${RPMURL}
RUN dnf install -y procps-ng
RUN dnf install -y unzip
RUN dnf install -y mongodb-server
RUN dnf install -y java-1.8.0-openjdk
RUN dnf install -y apache-commons-daemon
RUN dnf install -y apache-commons-daemon-jsvc
RUN dnf clean all

RUN curl -o /tmp/UniFi.unix.zip ${PKGURL}
RUN unzip -q /tmp/UniFi.unix.zip -d /opt
RUN rm -f /tmp/UniFi.unix.zip

ENV BASEDIR=/opt/UniFi \
  DATADIR=/opt/UniFi/data \
  RUNDIR=/opt/UniFi/run \
  LOGDIR=/opt/UniFi/logs \
  JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk \
  JVM_MAX_HEAP_SIZE=1024M \
  JVM_INIT_HEAP_SIZE=

VOLUME ["${DATADIR}", "${LOGDIR}"]

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp

COPY unifi.sh /opt/UniFi/
RUN chmod +x /opt/UniFi/unifi.sh

WORKDIR /opt/UniFi

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/UniFi/unifi.sh"]
