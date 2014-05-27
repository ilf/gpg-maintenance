#! /bin/sh
### BEGIN INIT INFO
# Provides:          gpg-maintenance
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      S 0 1 6
# Short-Description: GnuPG maintenance
# Description:       The gpg-maintenance script:
#                    - refreshes the keyring
#                    - creates an autoencrypt file for mutt
#                    - creates aliases for mutt
### END INIT INFO

PATH=/usr/sbin:/usr/bin:/sbin:/bin
DESC="GnuPG maintenance"
NAME=gpg-maintenance
DAEMON=/usr/local/bin/$NAME.sh
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME
USER=ilf

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Load the VERBOSE setting and other rcS variables
[ -f /etc/default/rcS ] && . /etc/default/rcS

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
	# make sure we can access PID
	touch $PIDFILE
	chown $USER $PIDFILE

        # Return
        #   0 if daemon has been started
        #   1 if daemon was already running
        #   2 if daemon could not be started
        start-stop-daemon --start --quiet --pidfile $PIDFILE --chuid $USER --exec $DAEMON --test > /dev/null \
                || return 1
        start-stop-daemon --start --quiet --pidfile $PIDFILE --chuid $USER --exec $DAEMON \
                || return 2
}

#
# Function that stops the daemon/service
#
do_stop()
{
        # Return
        #   0 if daemon has been stopped
        #   1 if daemon was already stopped
        #   2 if daemon could not be stopped
        #   other if a failure occurred
	start-stop-daemon --stop --quiet --retry=TERM/5/KILL/5 --pidfile $PIDFILE --exec $DAEMON
        RETVAL="$?"
        [ "$RETVAL" = 2 ] && return 2
        rm -f $PIDFILE
        return "$RETVAL"
}

case "$1" in
  start)
    [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
    do_start
    case "$?" in
        0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
        2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
  stop)
    [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
    do_stop
    case "$?" in
        0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
        2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
    esac
    ;;
  *)
    echo "Usage: $SCRIPTNAME {start|stop}" >&2
    exit 3
    ;;
esac

exit 0
