# HAProxy

A load balancer and reverse proxy for TCP and HTTP.

- **Upstream project**:
  [HAProxy](https://github.com/haproxytech/haproxy-docker-ubuntu)
- **Documentation**:
  [HAProxy on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/haproxy/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `haproxy.cfg` to `/docker/haproxy/production/haproxy.cfg`. Docker
   creates the other directories under `/docker/haproxy/` on the first start.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Access

HAProxy has no web interface. The `main` frontend in `haproxy.cfg` listens on
port 80:

```bash
http://your-ip-address:80
```

Port 8404 is published as well, but `haproxy.cfg` does not define a stats page
on it.

## Default Login Credentials

HAProxy has no login. Configure the frontends and backends in `haproxy.cfg`.
