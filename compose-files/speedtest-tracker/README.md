# Speedtest Tracker

Runs scheduled internet speed tests and keeps the results, with a MariaDB
database.

- **Upstream project**:
  [Speedtest Tracker](https://github.com/alexjustesen/speedtest-tracker)
- **Documentation**:
  [Speedtest Tracker on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/speedtest-tracker/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `my.cnf` to `/docker/speedtest-tracker/production/my.cnf`. Docker
   creates the other directories under `/docker/speedtest-tracker/` on the first
   start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Speedtest Tracker web interface using the following URL:

```bash
http://your-ip-address:3013
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
