#!/usr/bin/env bash

sudo sed -i \
        -e "s|%(ENV_USER)s|$USER|" \
        -e "s|%(ENV_HOME)s|$HOME|" \
        -e "s|%(ENV_DISPLAY_WIDTH)s|$DISPLAY_WIDTH|" \
        -e "s|%(ENV_DISPLAY_HEIGHT)s|$DISPLAY_HEIGHT|" \
    /etc/supervisor/supervisord.conf /etc/supervisor/conf.d/*.conf

sudo /usr/bin/supervisord -n --configuration /etc/supervisor/supervisord.conf &

SUPERVISOR_PID=$!

function shutdown {
    echo "Trapped SIGTERM/SIGINT/x so shutting down supervisord..."
    kill -s SIGTERM ${SUPERVISOR_PID}
    wait ${SUPERVISOR_PID}
    echo "Shutdown complete"
}

trap shutdown SIGTERM SIGINT
wait ${SUPERVISOR_PID}

