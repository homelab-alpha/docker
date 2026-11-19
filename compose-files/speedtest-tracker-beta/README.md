# Speedtest Tracker Beta

The beta version of Speedtest Tracker, with a MariaDB database.

- **Upstream project**:
  [Speedtest Tracker](https://github.com/alexjustesen/speedtest-tracker)
- **Documentation**:
  [Speedtest Tracker Beta on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/speedtest-tracker-beta/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Start the `speedtest-tracker` stack first. This stack joins its
   `speedtest-tracker` network, with the database on `172.20.23.4` and the app
   on `172.20.23.5`.

2. Copy `my.cnf` to `/docker/speedtest-tracker-beta/testing/my.cnf`. Docker
   creates the other directories under `/docker/speedtest-tracker-beta/` on the
   first start.

3. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

4. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Speedtest Tracker Beta web interface using the following URL:

**HTTP**:

```bash
http://your-ip-address:80
```

**HTTPS**:

```bash
https://your-ip-address:443
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
StrongUniqueUserPassword9012
```

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended that you change the default
> credentials after your first login.**
