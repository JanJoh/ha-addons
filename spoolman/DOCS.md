# Spoolman

This add-on runs [Spoolman](https://github.com/Donkie/Spoolman), a self-hosted
inventory of 3D printer filament: spools, filaments and manufacturers, how much is
left on each spool, labels with QR codes, and usage reported by your printer.

Spoolman itself is unchanged. The add-on puts nginx in front of it so the web UI
works inside Home Assistant (ingress), and keeps the database in the add-on's data
folder.

## Opening Spoolman

Start the add-on and turn on **Show in sidebar**, or use **Open web UI**. Spoolman
opens inside Home Assistant; anyone who can open the sidebar panel can use it, and
Spoolman has no login of its own.

## Connecting other software

Clients that talk to Spoolman's API use port **7912**:

| Client | Address |
|---|---|
| Spoolman integration in Home Assistant | `http://<hostname>:7912`, where `<hostname>` is shown on the add-on's **Info** tab (for example `809aec33-spoolman`). Works without mapping the port. |
| Moonraker/Klipper, OctoPrint, other machines on your network | `http://<home-assistant-ip>:7912`. Set a host port under **Network** first; it is off by default. |

Spoolman's API is at `/api/v1` on that address, for example
`http://<home-assistant-ip>:7912/api/v1/spool`.

Opening port 7912 on the host also gives direct access to the web UI, without Home
Assistant's login in front. Only map it if that is acceptable on your network.

## Options

| Option | Default | Description |
|---|---|---|
| `automatic_backup` | `true` | Spoolman's own nightly copy of its database, keeping the last 5, in the add-on's data folder. Home Assistant backups include the database either way. |
| `log_level` | _(Spoolman's default, info)_ | `debug`, `info`, `warning` or `error`. |

## Data

The database is `/data/spoolman.db` inside the add-on, with Spoolman's backups in
`/data/backups`. Both are included in Home Assistant backups,
and restoring a backup restores your spools.

## Versions

The add-on version is the Spoolman version it runs. Spoolman's changelog:
<https://github.com/Donkie/Spoolman/releases>.

## Licence

Spoolman is MIT licensed, © Daniel Hultgren. The add-on wrapper is part of
[JanJoh/ha-addons](https://github.com/JanJoh/ha-addons).
