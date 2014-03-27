# rsyslogd server
FROM ubuntu:raring
MAINTAINER Joel Pitt <joel@ideegeo.com>

RUN apt-get update
RUN apt-get install -y rsyslog
RUN apt-get clean

# Expose syslogd ports
EXPOSE 514/udp
EXPOSE 10514

ADD ./rsyslog.conf /etc/rsyslog.conf

CMD ["/usr/sbin/rsyslogd", "-n", "-c5"]
