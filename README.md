# JanJoh's Home Assistant add-ons and integrations

One add-on and three custom integrations for Home Assistant. Everything runs locally: no
cloud service and no accounts.

| | Type | What it does | Version |
|---|---|---|---|
| [Metadata Remote](#metadata-remote) | Add-on | Edit tags and album art of your music from the HA sidebar | [![Version](https://img.shields.io/github/v/tag/JanJoh/ha-addons?label=)](./metadata_remote/CHANGELOG.md) |
| [Phase Map](#phase-map) | Integration (HACS) | Which load is on which phase, and how much headroom each phase has | [![Release](https://img.shields.io/github/v/release/JanJoh/ha-phase-map?label=)](https://github.com/JanJoh/ha-phase-map/releases) |
| [GARO Entity Balance Meter](#garo-entity-balance-meter) | Integration (HACS) | Your grid meter, read from a GARO Entity Balance | [![Release](https://img.shields.io/github/v/release/JanJoh/Garo-entity-balance-meter-ha?label=)](https://github.com/JanJoh/Garo-entity-balance-meter-ha/releases) |
| [GARO Entity Charger Meter](#garo-entity-charger-meter) | Integration (HACS) | Energy, current and charging state of a GARO Entity charger | [![Release](https://img.shields.io/github/v/release/JanJoh/Garo-entity-charger-meter-ha?label=)](https://github.com/JanJoh/Garo-entity-charger-meter-ha/releases) |

## Add-ons

Add this repository to Home Assistant: **Settings → Add-ons → Add-on Store → ⋮ →
Repositories**, add `https://github.com/JanJoh/ha-addons`, or use the button.

[![Add repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FJanJoh%2Fha-addons)

### Metadata Remote

A web editor for the tags and album art of your audio files, inside Home Assistant.

<img src="https://raw.githubusercontent.com/JanJoh/metadata-remote/v1.2.11/screenshots/main-interface.png" alt="Metadata Remote" width="640">

- **In the sidebar:** the editor runs through ingress, with no extra port or login.
- **Music on a NAS:** mounts a CIFS/SMB share at start, or uses Home Assistant's `/media`.
- **Tags as they are:** standard fields always shown, custom fields with name suggestions,
  multi-value genre and performer.

**Needs:** Home Assistant OS or Supervised (add-ons). ·
[Documentation](./metadata_remote/DOCS.md) · [Changelog](./metadata_remote/CHANGELOG.md) ·
[Issues](https://github.com/JanJoh/ha-addons/issues)

## Integrations

Custom integrations are installed through [HACS](https://hacs.xyz): **HACS → ⋮ → Custom
repositories**, add the repository with type **Integration**, or use the button under each
one. Then download it and restart Home Assistant.

### Phase Map

Which load is on which phase of your main fuse, and how much headroom each phase has.

<img src="https://raw.githubusercontent.com/JanJoh/ha-phase-map/main/docs/images/card-light.png" alt="Phase Map card" width="640">

- **Per phase:** headroom, an overload warning, and the current no meter explains.
- **Knows where loads are:** suggests each meter's phase from history, notices when one has
  moved, and (optionally) finds meters you have not added.
- **A dashboard card** drawing the main fuse as a single-line diagram, included.

**Needs:** a sensor per phase of the main fuse that updates within seconds. ·
[Documentation](https://github.com/JanJoh/ha-phase-map#readme) ·
[Issues](https://github.com/JanJoh/ha-phase-map/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=ha-phase-map&category=integration)

### GARO Entity Balance Meter

Your grid meter, read from a GARO Entity Balance load balancer over its local API.

- **For the Energy dashboard:** total imported energy as the grid source; no separate P1
  reader needed.
- **Live:** power, and current and voltage per phase, every 15 seconds.
- **Diagnostics** (off by default): temperatures, firmware, network.

**Needs:** a GARO Entity Balance on the utility meter's P1 port, and the login on its sticker. ·
[Documentation](https://github.com/JanJoh/Garo-entity-balance-meter-ha#readme) ·
[Issues](https://github.com/JanJoh/Garo-entity-balance-meter-ha/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=Garo-entity-balance-meter-ha&category=integration)

### GARO Entity Charger Meter

The built-in meter and charging state of a GARO Entity EV charger, over its local API.

- **For the Energy dashboard:** the charger's imported energy.
- **Live:** power, and current and voltage per phase (optional), every 15 seconds.
- **Charging:** the vehicle state (connected, charging), CP and PP signal levels.

**Needs:** a GARO Entity charger with the local REST API, and the login on its sticker. ·
[Documentation](https://github.com/JanJoh/Garo-entity-charger-meter-ha#readme) ·
[Issues](https://github.com/JanJoh/Garo-entity-charger-meter-ha/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=Garo-entity-charger-meter-ha&category=integration)

## License & attribution

This project is licensed under the **GNU Affero General Public License v3.0**
(see [LICENSE](./LICENSE)).

The Metadata Remote add-on bundles
[metadata-remote](https://github.com/wow-signal-dev/metadata-remote) by
Dr. William Nelson Leonard (wow-signal-dev), which is also AGPL-3.0.

**Modifications:** the add-on runs a lightly patched fork
([JanJoh/metadata-remote](https://github.com/JanJoh/metadata-remote)). Changes
vs. upstream:

- Allow embedding in the Home Assistant ingress iframe
  (`X-Frame-Options: SAMEORIGIN`, CSP `frame-ancestors 'self'`).
- Honor the HA ingress base path (`X-Ingress-Path` → `SCRIPT_NAME`) so assets
  and API calls resolve correctly when embedded.
- Always show the standard metadata fields (so they can be added when missing)
  and suggest well-known tag names when adding custom fields.

Per the AGPL, complete corresponding source for the bundled app is available at
the fork repository linked above.
