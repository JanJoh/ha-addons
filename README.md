# JanJoh's Home Assistant add-ons and integrations

One add-on, four custom integrations and two dashboard cards for Home Assistant. Everything
runs locally: no cloud service and no accounts.

| | Type | What it does | Version |
|---|---|---|---|
| [Metadata Remote](#metadata-remote) | Add-on | Edit tags and album art of your music from the HA sidebar | [![Version](https://img.shields.io/github/v/tag/JanJoh/ha-addons?label=)](./metadata_remote/CHANGELOG.md) |
| [Phase Map](#phase-map) | Integration (HACS) | Which load is on which phase, and how much headroom each phase has | [![Release](https://img.shields.io/github/v/release/JanJoh/ha-phase-map?label=)](https://github.com/JanJoh/ha-phase-map/releases) |
| [GARO Entity Balance Meter](#garo-entity-balance-meter) | Integration (HACS) | Your grid meter, read from a GARO Entity Balance | [![Release](https://img.shields.io/github/v/release/JanJoh/Garo-entity-balance-meter-ha?label=)](https://github.com/JanJoh/Garo-entity-balance-meter-ha/releases) |
| [GARO Entity Charger Meter](#garo-entity-charger-meter) | Integration (HACS) | Energy, current and charging state of a GARO Entity charger | [![Release](https://img.shields.io/github/v/release/JanJoh/Garo-entity-charger-meter-ha?label=)](https://github.com/JanJoh/Garo-entity-charger-meter-ha/releases) |
| [Thermia Genesis (fork)](#thermia-genesis-fork) | Integration (HACS) | A Thermia ground source heat pump over local Modbus, with fixes not yet upstream | [![Release](https://img.shields.io/github/v/release/JanJoh/thermiagenesis?label=)](https://github.com/JanJoh/thermiagenesis/releases) |
| [Calibra Card](#calibra-card) | Dashboard card (HACS) | The heat pump drawn as it is plumbed: borehole, compressor, pumps, valve, tank | [![Release](https://img.shields.io/github/v/release/JanJoh/calibra-card?label=)](https://github.com/JanJoh/calibra-card/releases) |
| [Atlas Card](#atlas-card) | Dashboard card (HACS) | A Calibra Card variant for a Thermia Atlas with an external water heater and a hot gas exchanger (HGW). Written without the hardware | [![Release](https://img.shields.io/github/v/release/JanJoh/atlas-card?label=)](https://github.com/JanJoh/atlas-card/releases) |

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

### Thermia Genesis (fork)

A Thermia heat pump (Calibra, Diplomat Inverter, Mega) read and controlled over its local
Modbus interface. This is a fork of [CJNE/thermiagenesis](https://github.com/CJNE/thermiagenesis);
all credit for the integration goes there. The fork exists to install through HACS and to carry
fixes until they land upstream.

- **Fewer outages:** enabling the alarm class E or oil boost registers no longer takes every
  entity down, and entities are no longer `unknown` for 30 seconds after a reload.
- **Correct values:** pool temperature scaling, the firmware version, and the gear limit
  following the compressor's own gears (10 on a Calibra).
- **More to see:** demand sensors keep their history as a timeline, the heating stop is limited
  to 5–25 °C, and the internal immersion heater's step and state are available on Mega.

**Needs:** a Thermia Genesis-platform heat pump on the network with Modbus TCP enabled. ·
[What the fork changes](https://github.com/JanJoh/thermiagenesis#readme) ·
[Issues](https://github.com/JanJoh/thermiagenesis/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=thermiagenesis&category=integration)

## Dashboard cards

Cards are installed through HACS as well: add the repository with type **Dashboard**, or use
the button. HACS registers the card as a dashboard resource.

### Calibra Card

A Thermia Calibra heat pump drawn as it is actually plumbed, live, from the Thermia Genesis
integration above.

<img src="https://raw.githubusercontent.com/JanJoh/calibra-card/main/images/heat-light-760.png" alt="Calibra Card" width="640">

- **The whole system:** borehole, compressor gears, brine and condenser pumps, the diverting
  valve, radiators, the hot-water tank and an optional separate water heater.
- **Why it does what it does:** a line under the title explains a limited gear, a heating stop,
  the immersion heater coming on, an alarm, or your own notices.
- **Energy signature card,** included: daily energy against outdoor temperature, to compare two
  periods such as an old and a new pump.

**Needs:** the Thermia Genesis integration (this fork). ·
[Documentation](https://github.com/JanJoh/calibra-card#readme) ·
[Issues](https://github.com/JanJoh/calibra-card/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=calibra-card&category=plugin)

### Atlas Card

> **Written blind:** I don't have an Atlas or a hot gas exchanger. The card follows the Thermia
> Genesis register map, not a real installation. Reports from real systems are welcome.

A variant of the Calibra Card for a Thermia Atlas without a built-in tank: an external water
heater, and a hot gas heat exchanger (HGW) that heats the tank from the compressor's hot gas.

<img src="https://raw.githubusercontent.com/JanJoh/atlas-card/main/images/heat-light-760.png" alt="Atlas Card" width="640">

- **The HGW loop** from the compressor to the tank, with its status, the hot gas temperature and
  the temperature going to the tank.
- **The external water heater,** charged through the diverting valve, with its temperatures
  over time.
- **The same diagram as the Calibra Card** for the borehole, compressor, pumps and radiators.

**Needs:** the Thermia Genesis integration (this fork), with its HGW entities enabled; the
README lists them. ·
[Documentation](https://github.com/JanJoh/atlas-card#readme) ·
[Issues](https://github.com/JanJoh/atlas-card/issues)

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=atlas-card&category=plugin)

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
