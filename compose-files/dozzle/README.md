# Dozzle

A real-time log viewer for Docker containers.

- **Upstream project**: [Dozzle](https://github.com/amir20/dozzle)
- **Documentation**:
  [Dozzle on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/dozzle/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `users.yml` to `/docker/dozzle/users.yml`. Docker creates the other
   directories under `/docker/dozzle/` on the first start.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Dozzle web interface using the following URL:

```bash
http://your-ip-address:3008
```

## Default Login Credentials

> [!NOTE]
>
> If you have added users in the `users.yml` file, use those credentials
> instead.

**Username**: No username is required.

**Password**: No password is required.

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to configure authentication
> using the `users.yml` file to restrict access.**
