# AdGuard Home

A network-wide DNS server that blocks ads and tracking.

- **Upstream project**:
  [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome)
- **Documentation**:
  [AdGuard Home on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/adguard-home/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Make sure that port 53 on the host is free. On many Linux distributions
   `systemd-resolved` uses it.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the AdGuard Home web interface using the following URL:

**Setup wizard (first start only)**:

```bash
http://your-ip-address:3000
```

**Dashboard (after the setup, on the port chosen in the wizard)**:

```bash
http://your-ip-address:80
```

## Default Login Credentials

**Username**: Created during setup

**Password**: Created during setup

The setup wizard has no default credentials: you create the admin account in it.

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
