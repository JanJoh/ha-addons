# Changelog

## 1.2.6

- Standard fields (Title, Artist, Album, Album Artist, Year, Genre, Track #,
  Disc #, Composer) are now always shown and editable, even on files that don't
  have them yet.
- The "add new field" input now suggests common tag names (ALBUMARTIST-style
  Vorbis names, MusicBrainz/ReplayGain identifiers, etc.) via autocomplete;
  custom names are still allowed.

## 1.2.5

- Moved **SMB protocol version** and **Extra mount options** to advanced
  (optional) settings — they are now hidden under "Show unused optional
  configuration options" and default to `3.0` / `noserverino` via `run.sh`.
- Added friendly names and descriptions for all configuration options.

## 1.2.4

First fully working release.

- Wraps the patched [metadata-remote](https://github.com/JanJoh/metadata-remote)
  fork as a Home Assistant ingress add-on.
- Mounts a CIFS/SMB share at runtime (or falls back to `/media` when no SMB
  host is configured).
- Custom AppArmor profile permitting the `mount` syscall (modelled on Music
  Assistant) plus `SYS_ADMIN` + `DAC_READ_SEARCH` capabilities.
- Base image carries ingress base-path support (`X-Ingress-Path` →
  `SCRIPT_NAME`) so the UI renders correctly embedded in the HA frontend.
- Includes `curl` so bashio can reach the Supervisor API.
