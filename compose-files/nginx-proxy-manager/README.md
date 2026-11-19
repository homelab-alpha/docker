# Nginx Proxy Manager

A reverse proxy with a web interface and free SSL certificates, with a MariaDB
database.

- **Upstream project**:
  [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)
- **Documentation**:
  [Nginx Proxy Manager on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/nginx-proxy-manager/)

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

Access the Nginx Proxy Manager web interface using the following URL:

```bash
http://your-ip-address:81
```

## Default Login Credentials

> [!NOTE]
>
> If you have changed these values in the `.env` and or `stack.env` file, use
> those credentials instead of the default ones.

**Username**:

```bash
admin@example.com
```

**Password**:

```bash
StrongUniqueAdminPassword1234
```

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended that you change the default
> credentials after your first login.**
