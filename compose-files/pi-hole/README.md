# Pi-hole

A network-wide DNS server that blocks ads and tracking.

- **Upstream project**:
  [Pi-hole Docker image](https://github.com/pi-hole/docker-pi-hole)
- **Documentation**:
  [Pi-hole on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/pi-hole/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Pi-hole web interface using the following URL:

```bash
http://your-ip-address:3080/admin/login
```

DNS is published on port 5353 (TCP and UDP).

## Default Login Credentials

**Username**: No username is required.

**Password**:

The password for the first setup is in the logs (`docker logs pi-hole`). Look
for a line similar to:

```log
No password set in environment or config file, assigning random password: <password>
```

Change it afterwards with:

```bash
docker exec -it pi-hole pihole setpassword
```

The Compose file does not set a password on purpose: a password in
`FTLCONF_webserver_api_password` is visible in the Compose file and can no
longer be changed from inside the container.

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended that you change the default
> credentials after your first login.**
