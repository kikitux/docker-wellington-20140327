FROM ubuntu:latest
MAINTAINER joel@ideegeo.com

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y openssh-server rsyslog supervisor

RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

ADD ./supervisord.conf /etc/supervisor/supervisord.conf
ADD ./start_supervisor.sh /start_supervisor.sh
# Allow us to see the supervisor
EXPOSE 9001

# Add rsyslog config to monitor supervisord activity
ADD ./rsyslog-supervisor.conf /etc/rsyslog.d/supervisor.conf
ADD ./supervisor-rsyslog.conf /etc/supervisor/conf.d/rsyslog.conf
RUN chown syslog:syslog /var/spool/rsyslog/

# Add sshd, and expose port
ADD ./supervisor-ssh.conf /etc/supervisor/conf.d/sshd.conf
EXPOSE 22

ENTRYPOINT ["/start_supervisor.sh"]
