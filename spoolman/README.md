# Spoolman

Keep track of your 3D printer filament spools from the Home Assistant sidebar.

Runs [Spoolman](https://github.com/Donkie/Spoolman) by Daniel Hultgren, unchanged,
and adds:

- **Ingress:** Spoolman opens inside the Home Assistant UI, with no extra port or login.
- **An API port** for the [Spoolman integration](https://github.com/Disane87/spoolman-homeassistant),
  Moonraker/Klipper, OctoPrint and label printers.
- **Backups:** the spool database lives in the add-on's data folder, so it is part of
  your Home Assistant backups.

See [DOCS.md](./DOCS.md) for setup and the options.
