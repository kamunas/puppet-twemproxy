#! /bin/sh
### BEGIN INIT INFO
# Provides:     twemproxy
# Required-Start:   $syslog
# Required-Stop:    $syslog
# Should-Start:     $local_fs
# Should-Stop:      $local_fs
# Default-Start:    2 3 4 5
# Default-Stop:     0 1 6
# Short-Description:  twemproxy
# Description:     twemproxy
### END INIT INFO

# nutcracker -d -c /etc/twemproxy/nutcracker.yml -p /var/log/twemproxy.pid
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
EXEC=`which nutcracker`
CONF=/etc/twemproxy/nutcracker.yml
DAEMON_ARGS="$CONFIG_FILE"
NAME=nutcracker
DESC=nutcracker
PIDFILE=/var/run/nutcracker.pid
. /lib/lsb/init-functions

test -x $DAEMON || exit 0
test -x $DAEMONBOOTSTRAP || exit 0

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                echo "Starting twemproxy server..."
                $EXEC -d -c $CONF -p $PIDFILE
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                echo "Stopping ..."
                killproc -p $PIDFILE $EXEC
                echo "twemproxy stopped"
        fi
        ;;
    status)
        status_of_proc -p "${PIDFILE}" "${DAEMON}" "${NAME}"
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac
