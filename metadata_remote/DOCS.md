# Metadata Remote

A Home Assistant add-on that wraps [metadata-remote](https://github.com/wow-signal-dev/metadata-remote),
a lightweight web-based editor for audio file metadata (tags, album art, etc.).

The add-on runs the editor and embeds its web UI directly in the Home Assistant
frontend via **ingress** — no extra port or login required.

## What it does

- Serves the metadata-remote web UI inside Home Assistant (ingress / iframe).
- Optionally mounts a **CIFS/SMB network share** at runtime so you can edit
  metadata of music stored on a NAS or file server.
- If no SMB share is configured, it falls back to the standard Home Assistant
  `/media` share.

## Configuration

All options are set from the add-on **Configuration** tab.

| Option          | Required | Default        | Description |
|-----------------|----------|----------------|-------------|
| `smb_host`      | no       | _(empty)_      | Hostname or IP of the SMB/CIFS server, e.g. `192.168.1.10` or `nas.local`. **Leave blank to use the HA `/media` share instead.** |
| `smb_share`     | if host  | _(empty)_      | The share name on the server, e.g. `music`. |
| `smb_user`      | if host  | _(empty)_      | Username for the share. |
| `smb_password`  | if host  | _(empty)_      | Password for the share. |
| `smb_version`   | yes      | `3.0`          | SMB protocol version passed as `vers=`. Use `2.1` or `2.0` for older servers. |
| `smb_options`   | no       | `noserverino`  | Extra comma-separated CIFS mount options appended verbatim (e.g. `noserverino,uid=0,gid=0`). |
| `music_subpath` | no       | _(empty)_      | A subfolder **within** the share to use as the music root, e.g. `Library/FLAC`. Leave blank to use the share root. |

### Example (mount a NAS share)

```yaml
smb_host: "192.168.1.10"
smb_share: "music"
smb_user: "media"
smb_password: "supersecret"
smb_version: "3.0"
smb_options: "noserverino"
music_subpath: "FLAC"
```

This mounts `//192.168.1.10/music` inside the container and edits files under
`/music/FLAC`.

### Example (use the Home Assistant media share)

Leave `smb_host` blank. The add-on then uses `/media` (the standard Home
Assistant media folder) as the music directory — no mounting required.

## Notes

- **`SYS_ADMIN` privilege is required** for mounting SMB/CIFS shares from inside
  the container. This is the same requirement as the Music Assistant add-on. It
  is requested automatically via the add-on's `privileged` setting; you do not
  need to enable anything extra.
- **If `smb_host` is left blank**, the add-on falls back to `/media`, the
  standard Home Assistant media share (mapped read/write).
- After changing any option, **restart the add-on** for the new mount to take
  effect.
- If mounting fails, check the add-on **Log** tab — the exact `mount` error is
  printed there.
