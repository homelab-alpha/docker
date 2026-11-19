# MariaDB

A standalone MariaDB database server.

- **Upstream project**:
  [MariaDB Docker image](https://github.com/MariaDB/mariadb-docker)
- **Documentation**:
  [MariaDB on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/mariadb/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Copy `config/my.cnf` to `/docker/mariadb/config/my.cnf`. Docker creates the
   other directories under `/docker/mariadb/` on the first start.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Connection

MariaDB has no web interface. The port is published on the host only
(`127.0.0.1`), so connect from the host itself:

```bash
mariadb --host 127.0.0.1 --port 3306 --user root --password
```

## Default Login Credentials

**Username**: root

**Password**: The value of `ROOT_PASSWORD_DB` in the `.env` or `stack.env` file.
