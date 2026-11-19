# UniFi Network Application

Manages UniFi network devices, with a MongoDB database.

- **Upstream project**:
  [UniFi Network Application Docker image](https://github.com/linuxserver/docker-unifi-network-application)
- **Documentation**:
  [UniFi Network Application on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/unifi-network-application/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `init-mongo.sh` to `/docker/unifi-network-application/init-mongo.sh`.
   Docker creates the other directories under
   `/docker/unifi-network-application/` on the first start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the UniFi Network Application web interface using the following URL:

```bash
https://your-ip-address:8443
```

The application uses a self-signed certificate, so your browser shows a warning
on the first visit.

## Default Login Credentials

> [!NOTE]
>
> On the first visit, the setup wizard creates the administrator account or
> restores a backup.

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
