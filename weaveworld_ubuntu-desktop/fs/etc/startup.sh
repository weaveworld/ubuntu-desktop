#!/usr/bin/env bash

# supervisord
sudo sed -i \
        -e "s|%(ENV_USER)s|$USER|" \
        -e "s|%(ENV_HOME)s|$HOME|" \
        -e "s|%(ENV_DISPLAY_WIDTH)s|$DISPLAY_WIDTH|" \
        -e "s|%(ENV_DISPLAY_HEIGHT)s|$DISPLAY_HEIGHT|" \
    /etc/supervisor/supervisord.conf /etc/supervisor/conf.d/*.conf

sudo /usr/bin/supervisord -n --configuration /etc/supervisor/supervisord.conf &

SUPERVISOR_PID=$!
function shutdown {
    echo "SIGTERM/SIGINT: shutting down supervisord"
    sudo kill -s SIGTERM ${SUPERVISOR_PID}
    wait ${SUPERVISOR_PID}
    echo "Shutdown complete"
}
trap shutdown SIGTERM SIGINT

if [ $# -eq 0 ]; then wait ${SUPERVISOR_PID}; exit 0; fi

if [ "$1" = "-" ]; then exit 0; fi

exec -a "$0" "$@"