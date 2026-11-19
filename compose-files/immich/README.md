# Immich

A self-hosted photo and video backup solution, with PostgreSQL, Valkey, and
machine learning.

- **Upstream project**: [Immich](https://github.com/immich-app/immich)
- **Documentation**:
  [Immich on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/immich/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Immich web interface using the following URL:

```bash
http://your-ip-address:3015
```

## Default Login Credentials

> [!NOTE]
>
> On the first visit, click **Getting Started**. The first user to register
> becomes the admin user.

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
