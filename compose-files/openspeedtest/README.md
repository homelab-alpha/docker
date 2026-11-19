# OpenSpeedTest

A network speed test that runs in the browser.

- **Upstream project**:
  [OpenSpeedTest](https://github.com/openspeedtest/Speed-Test)
- **Documentation**:
  [OpenSpeedTest on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/openspeedtest/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `nginx.conf` to `/docker/openspeedtest/production/config/nginx.conf`.
   Copy `OpenSpeedTest-Server.conf` to
   `/docker/openspeedtest/production/config/OpenSpeedTest-Server.conf`. Docker
   creates the other directories under `/docker/openspeedtest/` on the first
   start.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the OpenSpeedTest web interface using the following URL:

**HTTP**:

```bash
http://your-ip-address:3009
```

**HTTPS**:

```bash
https://your-ip-address:3010
```

## Default Login Credentials

**Username**: No username is required.

**Password**: No password is required.
