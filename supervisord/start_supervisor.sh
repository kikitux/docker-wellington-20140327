#!/bin/sh
SYSLOG_DEST="$SYSLOG_PORT_10514_TCP_ADDR:$SYSLOG_PORT_10514_TCP_PORT"
echo "Setting up syslog forwarding to ${SYSLOG_DEST}..."
echo "*.*	@@${SYSLOG_DEST}" >> /etc/rsyslog.conf

supervisord -c /etc/supervisor/supervisord.conf
