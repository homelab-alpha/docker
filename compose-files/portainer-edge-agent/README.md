# Portainer Edge Agent

Connects this Docker host to a Portainer server as an Edge environment.

- **Upstream project**: [Portainer Agent](https://github.com/portainer/agent)
- **Documentation**:
  [Portainer Edge Agent on homelab-alpha.nl](https://homelab-alpha.nl/docker/compose-info/portainer-edge-agent/)

## Quick Start

> [!NOTE]
>
> Requires Docker Compose 2.24.0 or later.

1. Change the values in `.env` (Docker Compose CLI) or `stack.env` (Portainer),
   at least the passwords.

2. In Portainer, add an Edge Agent environment and copy its Edge ID and Edge key
   to `PORTAINER_AGENT_ID` and `PORTAINER_AGENT_KEY`.

3. Start the stack:

   ```bash
   docker compose up -d
   ```

## Default Access

The Edge Agent has no web interface. It connects to your Portainer server, where
the environment shows up once the agent is running.

## Default Login Credentials

The agent has no login. It authenticates with `PORTAINER_AGENT_ID` and
`PORTAINER_AGENT_KEY` from the `.env` or `stack.env` file.
