#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

# The add-on's own /data mount: Spoolman checks that its data directory is a mount
# (and warns that data will be lost otherwise), so it gets /data itself.
DATA_DIR="/data"

# The ingress path is fixed for an installed add-on; Spoolman serves everything
# under it so its links work inside the Home Assistant frontend.
BASE_PATH="$(bashio::addon.ingress_entry)"
if ! bashio::var.has_value "${BASE_PATH}"; then
    bashio::exit.nok "Could not read the ingress path from the Supervisor."
fi
bashio::log.info "Ingress path: ${BASE_PATH}"

sed "s|__BASE__|${BASE_PATH}|g" /etc/nginx/spoolman.conf.tpl > /etc/nginx/nginx.conf
nginx -t -q

# Spoolman drops to its own "app" user (uid 1000); give it the data directory,
# leaving the Supervisor's options.json alone.
find "${DATA_DIR}" -path "${DATA_DIR}/options.json" -prune -o -exec chown 1000:1000 {} +

export SPOOLMAN_DIR_DATA="${DATA_DIR}"
export SPOOLMAN_BASE_PATH="${BASE_PATH}"
export SPOOLMAN_HOST="127.0.0.1"
export SPOOLMAN_PORT="8000"
if bashio::config.true 'automatic_backup'; then
    export SPOOLMAN_AUTOMATIC_BACKUP="TRUE"
else
    export SPOOLMAN_AUTOMATIC_BACKUP="FALSE"
fi
if bashio::config.has_value 'log_level'; then
    SPOOLMAN_LOGGING_LEVEL="$(bashio::config 'log_level' | tr '[:lower:]' '[:upper:]')"
    export SPOOLMAN_LOGGING_LEVEL
fi
# Dates in Spoolman follow Home Assistant's time zone.
TZ="$(bashio::info.timezone 2>/dev/null || true)"
if bashio::var.has_value "${TZ}"; then
    export TZ
fi

bashio::log.info "Starting nginx..."
nginx -g "daemon off;" &

bashio::log.info "Starting Spoolman..."
cd /home/app/spoolman
exec /home/app/spoolman/entrypoint.sh
