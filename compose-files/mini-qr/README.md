# Mini QR

A web app to create and scan QR codes, behind an Nginx proxy.

- **Upstream project**: [Mini QR](https://github.com/lyqht/mini-qr)
- **Documentation**:
  [Mini QR on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/mini-qr/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `nginx-proxy.conf` to `/docker/mini-qr/nginx-proxy.conf`. Docker creates
   the other directories under `/docker/mini-qr/` on the first start.

2. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Mini QR web interface using the following URL:

```bash
http://your-ip-address:3017
```

## Default Login Credentials

**Username**: No username is required.

**Password**: No password is required.
