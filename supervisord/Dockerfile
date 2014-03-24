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

# Add rsyslog config to monitor supervisord activity
ADD ./rsyslog-supervisor.conf /etc/rsyslog.d/supervisor.conf
ADD ./supervisor-rsyslog.conf /etc/supervisor/conf.d/rsyslog.conf

RUN chown syslog:syslog /var/spool/rsyslog/

# Custom services
#ADD ./files/uwsgi-supervisor.conf /etc/supervisor/conf.d/uwsgi.conf
#ADD ./files/cron-supervisor.conf /etc/supervisor/conf.d/cron.conf
#ADD ./files/rsyslog-supervisor.conf /etc/supervisor/conf.d/rsyslog.conf

#ADD ./files/uwsgi.ini /home/rsstank/uwsgi.ini
#ADD ./files/crontab /etc/crontab
#ADD ./files/cron-rsyslog.conf /etc/rsyslog.d/60-cron.conf
CMD ["/start_supervisor.sh"]
