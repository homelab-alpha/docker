# Jellyfin

A free media server for movies, series, and music.

- **Upstream project**: [Jellyfin](https://github.com/jellyfin/jellyfin)
- **Documentation**:
  [Jellyfin on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/jellyfin/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Put your media in `/docker/media`. The stack mounts it in the container.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Jellyfin web interface using the following URL:

**HTTP**:

```bash
http://your-ip-address:8096
```

**HTTPS (when configured)**:

```bash
https://your-ip-address:8920
```

## Default Login Credentials

> [!NOTE]
>
> On the first visit, the setup wizard creates the administrator account and
> asks for your media libraries.

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
