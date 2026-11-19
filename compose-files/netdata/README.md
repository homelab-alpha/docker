# Netdata

Real-time monitoring of the host and its containers.

- **Upstream project**: [Netdata](https://github.com/netdata/netdata)
- **Documentation**:
  [Netdata on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/netdata/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Netdata web interface using the following URL:

```bash
http://your-ip-address:19999
```

## Default Login Credentials

**Username**: No username is required.

**Password**: No password is required.

> [!IMPORTANT]
>
> **The local dashboard has no login. Do not expose it outside your network.**
