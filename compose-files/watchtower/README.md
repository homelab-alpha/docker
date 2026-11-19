# Watchtower

Updates running containers automatically when a new image is available.

- **Upstream project**:
  [Watchtower](https://github.com/nicholas-fedor/watchtower)
- **Documentation**:
  [Watchtower on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/watchtower/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Access

Watchtower has no web interface. Follow what it does in the logs:

```bash
docker logs watchtower
```

## Default Login Credentials

Watchtower has no login.
