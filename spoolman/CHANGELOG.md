# Changelog

## 0.27.1-1

- First version of the add-on, running Spoolman 0.27.1
  ([release notes](https://github.com/Donkie/Spoolman/releases/tag/v0.27.1)).
- The web UI opens in the Home Assistant sidebar through ingress; nginx in the
  add-on serves Spoolman under the ingress path (`SPOOLMAN_BASE_PATH`).
- Port 7912 for API clients (the Spoolman integration, Moonraker, OctoPrint),
  reachable from Home Assistant via the add-on's hostname and optionally mapped
  on the host.
- Database in the add-on's data folder, included in Home Assistant backups.
