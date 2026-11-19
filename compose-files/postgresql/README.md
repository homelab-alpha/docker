# PostgreSQL

A standalone PostgreSQL database server.

- **Upstream project**:
  [PostgreSQL Docker image](https://github.com/docker-library/postgres)
- **Documentation**:
  [PostgreSQL on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/postgresql/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `config/postgresql.conf` to `/docker/postgresql/config/postgresql.conf`.
   Docker creates the other directories under `/docker/postgresql/` on the first
   start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Connection

PostgreSQL has no web interface. The port is published on the host only
(`127.0.0.1`), so connect from the host itself:

```bash
psql --host 127.0.0.1 --port 5432 --username admin
```

## Default Login Credentials

**Username**: The value of `POSTGRES_SUPERUSER_NAME` (default `admin`).

**Password**: The value of `POSTGRES_SUPERUSER_PASSWORD` in the `.env` or
`stack.env` file.
