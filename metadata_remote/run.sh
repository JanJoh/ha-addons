#!/usr/bin/env bashio
# shellcheck shell=bash
set -e

MOUNT_POINT="/music"

if bashio::config.has_value 'smb_host'; then
    SMB_HOST="$(bashio::config 'smb_host')"
    SMB_SHARE="$(bashio::config 'smb_share')"
    SMB_USER="$(bashio::config 'smb_user')"
    SMB_PASSWORD="$(bashio::config 'smb_password')"

    # smb_version / smb_options are advanced options and may be unset; apply
    # the same defaults the visible config used to carry.
    if bashio::config.has_value 'smb_version'; then
        SMB_VERSION="$(bashio::config 'smb_version')"
    else
        SMB_VERSION="3.0"
    fi
    if bashio::config.has_value 'smb_options'; then
        SMB_OPTIONS="$(bashio::config 'smb_options')"
    else
        SMB_OPTIONS="noserverino"
    fi

    # The mount point may not exist in a fresh container.
    mkdir -p "${MOUNT_POINT}"

    # Build the CIFS mount option string.
    MOUNT_OPTS="username=${SMB_USER},password=${SMB_PASSWORD},vers=${SMB_VERSION}"
    if bashio::var.has_value "${SMB_OPTIONS}"; then
        MOUNT_OPTS="${MOUNT_OPTS},${SMB_OPTIONS}"
    fi

    bashio::log.info "Mounting //${SMB_HOST}/${SMB_SHARE} at ${MOUNT_POINT} (vers=${SMB_VERSION})..."

    if ! mount -t cifs "//${SMB_HOST}/${SMB_SHARE}" "${MOUNT_POINT}" -o "${MOUNT_OPTS}"; then
        bashio::log.error "Failed to mount CIFS share //${SMB_HOST}/${SMB_SHARE}"
        exit 1
    fi
    bashio::log.info "CIFS share mounted successfully."

    # Optional subfolder within the share.
    if bashio::config.has_value 'music_subpath'; then
        MUSIC_SUBPATH="$(bashio::config 'music_subpath')"
        MUSIC_DIR="${MOUNT_POINT}/${MUSIC_SUBPATH}"
    else
        MUSIC_DIR="${MOUNT_POINT}"
    fi
else
    # No SMB host configured: fall back to the standard HA media share.
    bashio::log.info "No smb_host configured; falling back to /media."
    MUSIC_DIR="/media"
fi

export MUSIC_DIR
bashio::log.info "Using MUSIC_DIR=${MUSIC_DIR}"

# The upstream app is installed in /app. Run from there so gunicorn finds
# gunicorn_config.py and the app:app module.
cd /app
exec gunicorn --config gunicorn_config.py app:app
