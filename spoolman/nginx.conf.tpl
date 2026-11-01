# Rendered by run.sh: __BASE__ becomes the ingress path (/api/hassio_ingress/<token>).
#
# Spoolman runs with SPOOLMAN_BASE_PATH=__BASE__, so its pages and API calls use
# that prefix. Home Assistant's ingress proxy strips the prefix before a request
# reaches the add-on, so nginx puts it back. The same rules serve the direct port,
# where clients use plain paths (/api/v1/...) and the browser then follows the
# prefixed links Spoolman hands out.
worker_processes 1;
pid /run/nginx.pid;
error_log /dev/stderr warn;

events {
    worker_connections 256;
}

http {
    access_log off;
    client_max_body_size 32m;
    proxy_read_timeout 1h;

    map $http_upgrade $connection_upgrade {
        default upgrade;
        ""      close;
    }

    server {
        listen 8099;
        listen 7912;

        # Keep the Host (and any X-Forwarded-Host) the browser used: Spoolman
        # compares them with Origin before it accepts a write.
        proxy_set_header Host $http_host;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_buffering off;

        # Already prefixed (links followed from a page served on the direct port).
        location ^~ __BASE__/ {
            proxy_pass http://127.0.0.1:8000;
        }

        location = __BASE__ {
            proxy_pass http://127.0.0.1:8000;
        }

        # Everything else: add the prefix.
        location / {
            proxy_pass http://127.0.0.1:8000__BASE__/;
        }
    }
}
