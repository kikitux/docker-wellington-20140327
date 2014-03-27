# Docker Wellington meetup example

While Docker containers are designed to run in isolated process environments and
communicate via the network (local or otherwise), we often want more than
*just* a single process running. More than that, we want guarantees that our
process will respawn if it dies and that the ability to introspect a container
when things are not quite right.

Well, at least **I** would like all these things.

In addition:

- I'd prefer to keep things minimal and not need some prebuilt super-stack
in every container.
- I'd like them extensible, so that individual steps in building a container
allow for extended the services provided and sharing a common base container.
- I'd like to be able to ssh and inspect containers.

There are two things I will use:

* Supervisor - for extensible process management. Makes it trivial to add new
services on a base image.
* Rsyslogd - for sending our logs to a remote logging container (or server).

## Quick start

Build the containers:
```
(cd syslog && docker-osx build -t rsyslog:latest .)
(cd supervisord && docker-osx build -t supervisord:latest .)
```

Run them in this order (note that it assumes you have a volumes dir in your
`/vagrant` folder. If you don't user vagrant put the log volume somewhere else
accessible).

```
docker-osx run -d -name rsyslog_sink -v /vagrant/volumes/meetup:/var/log/:rw -t rsyslog:latest 
docker-osx run -rm -i -name docker_meetup -e SSH_PASSWORD=foobar -link rsyslog_sink:syslog -p :22 -p :9001 -t supervisord:latest
```

To find the ports supervisor http is mapped to:
```
docker-osx port docker_meetup 9001
```

Connect to ssh:
```
ssh root@`docker-osx port docker_meetup 22 | sed -e 's/\:/ -p /'`
```

## If you want to use your host syslog

```
docker-osx run -rm -i \
    -e SYSLOG_PORT_10514_TCP_ADDR=YOUR_IP \
    -e SYSLOG_PORT_10514_TCP_PORT=YOUR_SYSLOG_PORT \
    -t supervisord:latest
```

## Extending the supervisor container

```
(cd widgets && docker-osx build -t widgets .)
docker-osx run -rm -i -name widgets -e SSH_PASSWORD=foobar -link rsyslog_sink:syslog -p :22 -p :9001 -t widgets:latest 
```
