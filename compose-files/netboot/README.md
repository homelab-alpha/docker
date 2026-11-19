# netboot.xyz

A network boot (PXE) server with a web interface to manage the boot menus.

- **Upstream project**:
  [netboot.xyz Docker image](https://github.com/netbootxyz/docker-netbootxyz)
- **Documentation**:
  [netboot.xyz on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/netboot/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Point the DHCP server of your network to this host as TFTP server (port
   69/udp). See `notes/netboot_boot_option.md`.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the netboot.xyz web interface using the following URL:

**Web configuration interface**:

```bash
http://your-ip-address:3011
```

## Default Login Credentials

**Username**: No username is required.

**Password**: No password is required.

> [!IMPORTANT]
>
> **The web interface has no login. Do not expose it outside your network.**
