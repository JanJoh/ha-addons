# Add-on wrapper image.
#
# Base = the PATCHED FORK image (built separately from JanJoh/metadata-remote).
# This wrapper layers in CIFS/SMB mounting support and the add-on entrypoint.
ARG BUILD_FROM=ghcr.io/janjoh/metadata-remote:latest
FROM ${BUILD_FROM}

# cifs-utils -> mount SMB/CIFS shares; bash -> run.sh interpreter.
# jq + curl + ca-certificates are required by bashio at runtime (curl is used
# to contact the Supervisor API; see below).
RUN apk add --no-cache cifs-utils bash jq curl ca-certificates

# bashio is normally provided by Home Assistant base images, but this add-on is
# built FROM the upstream metadata-remote python:alpine image, which does not
# include it. We install it explicitly so run.sh can use bashio::config helpers.
ARG BASHIO_VERSION=v0.16.2
RUN mkdir -p /tmp/bashio \
    && wget -qO- "https://github.com/hassio-addons/bashio/archive/${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip-components=1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio

# Add-on entrypoint: mounts the SMB share (if configured) then starts gunicorn.
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
