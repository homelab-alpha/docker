# FreshRSS

A self-hosted RSS feed aggregator, with a MariaDB database.

- **Upstream project**: [FreshRSS](https://github.com/FreshRSS/FreshRSS)
- **Documentation**:
  [FreshRSS on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/freshrss/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `my.cnf` to `/docker/freshrss/production/my.cnf`. Docker creates the
   other directories under `/docker/freshrss/` on the first start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the FreshRSS web interface using the following URL:

```bash
http://your-ip-address:3002
```

## Default Login Credentials

> [!NOTE]
>
> On the first visit, the installation wizard asks for the database and creates
> the admin account. Use MySQL/MariaDB with the host `freshrss_db` and the
> database name, user, and password from the `.env` or `stack.env` file.

**Username**: Created during setup

**Password**: Created during setup

> [!IMPORTANT]
>
> **For security reasons, it is strongly recommended to create a strong username
> and password during the setup.**
