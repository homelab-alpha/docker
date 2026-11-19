# Uptime Kuma

> [!CAUTION]
>
> ## ⚠️ Deprecated Project Notice
>
> The **Uptime Kuma** and **Uptime Kuma Beta** projects are officially
> **deprecated** by the Homelab-Alpha team. This decision was made because the
> [official project](https://github.com/louislam/uptime-kuma) is no longer
> properly maintained. As a result, these tools may contain **unresolved
> issues**, **bugs**, or **security vulnerabilities**.
>
> ➤ **Proceed with caution and use at your own risk.**

A self-hosted monitoring tool for uptime and status, with a MariaDB database.

- **Upstream project**: [Uptime Kuma](https://github.com/louislam/uptime-kuma)
- **Documentation**:
  [Uptime Kuma on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/uptime-kuma/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `my.cnf` to `/docker/uptime-kuma/production/my.cnf`. Docker creates the
   other directories under `/docker/uptime-kuma/` on the first start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

4. To monitor containers, open **Settings → Docker Hosts** in Uptime Kuma and
   add a Docker host with the connection type **TCP / HTTP** and the Docker
   daemon `http://uptime-kuma_socket-proxy:2375`. The stack has no direct access
   to the Docker socket; this read-only proxy is the only way in.

## Default Web Access

Access the Uptime Kuma web interface using the following URL:

```bash
http://your-ip-address:3001
```

## Default Login Credentials

> [!NOTE]
>
> Credentials are created during the initial setup process.

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
