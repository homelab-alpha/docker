# Plex Media Server

A media server for movies, series, and music, linked to your Plex account.

- **Upstream project**:
  [Plex Media Server Docker image](https://github.com/plexinc/pms-docker)
- **Documentation**:
  [Plex Media Server on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/plex/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Put your media in `/docker/media`. The stack mounts it in the container.

2. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

3. Get a claim token from <https://www.plex.tv/claim> and put it in
   `PLEX_CLAIM_TOKEN`. The token expires after a few minutes and is only used on
   the first start, so start the stack right after.

4. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Web Access

Access the Plex Media Server web interface using the following URL:

```bash
http://your-ip-address:32400/web
```

## Default Login Credentials

Sign in with your Plex account. The claim token links the server to that account
on the first start.
