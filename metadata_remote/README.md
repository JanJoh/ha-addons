# Metadata Remote

Web-based audio metadata editor for Home Assistant, embedded in the frontend
via ingress.

Wraps the [metadata-remote](https://github.com/wow-signal-dev/metadata-remote)
editor and adds:

- **CIFS/SMB mounting** at runtime — edit metadata of music on a NAS/file
  server, or fall back to the Home Assistant `/media` share.
- **Ingress** — opens inside the Home Assistant UI, no extra port or login.
- Always-visible standard fields (Title, Artist, Album, …) and autocomplete
  suggestions for well-known tag names when adding custom fields.

See [DOCS.md](./DOCS.md) for configuration details and the SMB options.

> **Note:** Mounting SMB shares requires the `SYS_ADMIN` capability (the same
> requirement as the Music Assistant add-on). A custom AppArmor profile keeps
> the add-on confined while permitting the `mount` syscall.
