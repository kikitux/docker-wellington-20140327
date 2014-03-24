# Docker Wellington meetup example

While containers are designed to run in isolated process environments and
communicate via the network (local or otherwise), we often want more than
*just* a single process running. More than that, we want guarantees that our
process will respawn if it dies and that the ability to introspect a container
when things are not quite right.

Well, at least **I** would like all these things.

I'd also prefer to keep things minimal and not need some prebuilt super-stack
in every container.

There are two things I will use:

* Supervisor - for extensible process management. Makes it trivial to add new
services on a base image.
* Rsyslogd - for sending our logs to a remote logging container (or server).

