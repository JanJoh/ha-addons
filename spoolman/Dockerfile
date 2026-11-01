# Add-on wrapper image.
#
# Base = the official Spoolman image (MIT, https://github.com/Donkie/Spoolman),
# pinned to the version this add-on carries. Spoolman itself is unchanged; this
# layer adds nginx (to serve it under Home Assistant ingress), bashio and run.sh.
# Bump BUILD_FROM and the version in config.yaml together.
ARG BUILD_FROM=ghcr.io/donkie/spoolman:0.27.1
FROM ${BUILD_FROM}

LABEL org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/JanJoh/ha-addons" \
      org.opencontainers.image.base.name="ghcr.io/donkie/spoolman:0.27.1" \
      org.opencontainers.image.description="Spoolman add-on for Home Assistant. Spoolman: https://github.com/Donkie/Spoolman"

USER root

# nginx -> ingress proxy; jq + curl + ca-certificates -> needed by bashio to
# talk to the Supervisor API.
RUN apt-get update \
    && apt-get install -y --no-install-recommends nginx jq curl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /etc/nginx/sites-enabled/default

# bashio is normally provided by Home Assistant base images; the upstream image
# is plain Debian, so install it explicitly (same as the Metadata Remote add-on).
ARG BASHIO_VERSION=v0.16.2
RUN mkdir -p /tmp/bashio \
    && curl -fsSL "https://github.com/hassio-addons/bashio/archive/${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip-components=1 -C /tmp/bashio \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    && rm -rf /tmp/bashio

COPY nginx.conf.tpl /etc/nginx/spoolman.conf.tpl
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT []
CMD ["/run.sh"]
