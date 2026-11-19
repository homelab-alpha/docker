# Portainer

A web interface to manage Docker environments.

- **Upstream project**: [Portainer](https://github.com/portainer/portainer)
- **Documentation**:
  [Portainer on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/portainer/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Portainer web interface using the following URL:

```bash
https://your-ip-address:9443
```

Portainer is only published over HTTPS. It uses a self-signed certificate by
default, so your browser shows a warning on the first visit.

Port 8000 is the tunnel server for Edge Agents.

## Default Login Credentials

> [!WARNING]
>
> Create the administrator account within **5 minutes** after the first start.
> After that, Portainer stops for security reasons. Restart the container to try
> again:
>
> ```bash
> docker compose restart
> ```

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
