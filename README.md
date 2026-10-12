# JanJoh's Home Assistant Add-ons

A small collection of Home Assistant add-ons.

## Installation

Add this repository to Home Assistant:

1. **Settings → Add-ons → Add-on Store**
2. Top-right **⋮ → Repositories**
3. Add `https://github.com/JanJoh/ha-addons` and close.

[![Add repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FJanJoh%2Fha-addons)

## Add-ons

### [Metadata Remote](./metadata_remote)

Web-based audio metadata editor (a wrapper around
[metadata-remote](https://github.com/wow-signal-dev/metadata-remote)) with
runtime CIFS/SMB mounting and Home Assistant ingress support. Edit tags and
album art for music stored on a NAS or the HA media share, directly from the
HA frontend.

## Integrations

Custom integrations are installed through [HACS](https://hacs.xyz) rather than
the Add-on Store. Add the repository as a custom repository (type
**Integration**) in HACS, or use the button.

### [HA Phase Map](https://github.com/JanJoh/ha-phase-map)

Which load is on which phase: headroom per phase against the main fuse,
unmetered current, nested meters, a live check that notices when a load has
moved phase, and a dashboard card drawing the fuse as a single-line diagram
(bundled with the integration).

[![Open in HACS](https://my.home-assistant.io/badges/hacs_repository.svg)](https://my.home-assistant.io/redirect/hacs_repository/?owner=JanJoh&repository=ha-phase-map&category=integration)

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
