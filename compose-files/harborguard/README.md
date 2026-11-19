# Harbor Guard

A web interface to scan container images for vulnerabilities.

- **Upstream project**:
  [Harbor Guard](https://github.com/HarborGuard/HarborGuard)
- **Documentation**:
  [Harbor Guard on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/harborguard/)

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

Access the Harbor Guard web interface using the following URL:

```bash
http://your-ip-address:3016
```

## Default Login Credentials

> [!NOTE]
>
> This setup uses an internal database and does **not** persist your data. For a
> production-ready setup with an external PostgreSQL database, refer to the
> [Harbor Guard GitHub documentation](https://github.com/HarborGuard/HarborGuard),
> including the
> [docker-compose.yml](https://github.com/HarborGuard/HarborGuard/blob/main/docker-compose.yml)
> and
> [.env.example](https://github.com/HarborGuard/HarborGuard/blob/main/.env.example)
> files.

**Username**: No username is required.

**Password**: No password is required.
