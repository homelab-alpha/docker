# Docker - Bridge Network Setup

A `bridge` network is a private network on the Docker host. Containers on it get
an address from its subnet, reach each other by name, and reach the internet
through the host (IP masquerading). From your LAN, you reach a container only
through a port that the stack publishes. Every stack in `compose-files/` uses
its own bridge network.

See [Choosing a network driver](./choosing_a_network_driver.md) for a comparison
with `ipvlan` and `macvlan`.

## Compose Example

This is the network block that the stacks use. Replace `example` with the name
of the stack and `172.20.30.0/24` with a free subnet from the
[IP plan](#ip-plan-of-the-stacks).

```yaml
networks:
  example_net:
    attachable: false
    internal: false
    external: false
    name: example
    driver: bridge
    ipam:
      driver: default
      config:
        - subnet: 172.20.30.0/24
          ip_range: 172.20.30.0/24
          gateway: 172.20.30.1
    driver_opts:
      com.docker.network.bridge.default_bridge: "false"
      com.docker.network.bridge.enable_icc: "true"
      com.docker.network.bridge.enable_ip_masquerade: "true"
      com.docker.network.bridge.host_binding_ipv4: "0.0.0.0"
      com.docker.network.bridge.name: "example"
      com.docker.network.driver.mtu: "1500"
    labels:
      com.example.network.description: "is an isolated bridge network."

services:
  example_app:
    image: docker.io/library/nginx:stable
    networks:
      example_net:
        ipv4_address: 172.20.30.2
    ports:
      - "8080:80/tcp"
```

- The key under `networks:` (`example_net`) is the name inside the Compose file.
  `name:` sets the name of the network in Docker.
- `ipv4_address` gives the container a fixed address. Leave it out to let Docker
  pick one from `ip_range`.
- `ports` publishes container port 80 on port 8080 of the host.

## CLI Example

Create the same network once with `docker network create`, for example when
several stacks share it:

```bash
docker network create \
  --driver bridge \
  --subnet 172.20.30.0/24 \
  --ip-range 172.20.30.0/24 \
  --gateway 172.20.30.1 \
  --opt com.docker.network.bridge.enable_icc=true \
  --opt com.docker.network.bridge.enable_ip_masquerade=true \
  --opt com.docker.network.bridge.host_binding_ipv4=0.0.0.0 \
  --opt com.docker.network.bridge.name=example \
  --opt com.docker.network.driver.mtu=1500 \
  --label com.example.network.description="is an isolated bridge network." \
  example
```

A stack joins this network with `external: true`. Docker Compose then does not
create or remove it:

```yaml
networks:
  example_net:
    external: true
    name: example
```

## Options

| Compose key or CLI option                        | Default          | Meaning                                                               |
| :----------------------------------------------- | :--------------- | :-------------------------------------------------------------------- |
| `internal` / `--internal`                        | `false`          | `true` blocks all traffic to and from outside the network.            |
| `attachable` / `--attachable`                    | `false`          | `true` lets standalone containers join with `docker network connect`. |
| `external`                                       | `false`          | Compose only: `true` means the network already exists.                |
| `ipam.config.subnet` / `--subnet`                | Chosen by Docker | The address range of the network.                                     |
| `ipam.config.ip_range` / `--ip-range`            | The subnet       | The part of the subnet that Docker hands out to containers.           |
| `ipam.config.gateway` / `--gateway`              | First address    | The address of the host on this network.                              |
| `com.docker.network.bridge.name`                 | `br-<id>`        | The name of the Linux bridge interface on the host.                   |
| `com.docker.network.bridge.enable_icc`           | `true`           | Lets the containers on this network talk to each other.               |
| `com.docker.network.bridge.enable_ip_masquerade` | `true`           | Lets the containers reach the internet through the host.              |
| `com.docker.network.bridge.host_binding_ipv4`    | All addresses    | The host address that published ports bind to.                        |
| `com.docker.network.driver.mtu`                  | `0` (no limit)   | The MTU of the container interfaces.                                  |

The stacks also set `com.docker.network.bridge.default_bridge: "false"`. That is
the value for every network except the default `bridge` network of Docker.

## IPv6

Add `enable_ipv6: true` and an IPv6 subnet. This example uses a unique local
address (ULA) prefix:

```yaml
networks:
  example_net:
    name: example
    driver: bridge
    enable_ipv6: true
    ipam:
      config:
        - subnet: 172.20.30.0/24
          gateway: 172.20.30.1
        - subnet: fd00:172:20:30::/64
          gateway: fd00:172:20:30::1
```

With the CLI, use `--ipv6` and a second `--subnet`:

```bash
docker network create --driver bridge --ipv6 \
  --subnet 172.20.30.0/24 --gateway 172.20.30.1 \
  --subnet fd00:172:20:30::/64 --gateway fd00:172:20:30::1 \
  example
```

If you leave out the IPv6 subnet, Docker picks a ULA prefix itself.

## IP Plan of the Stacks

Each production stack has its own `/24` subnet, so the networks never overlap:

- `172.20.<n>.0/24` for production stacks.
- The gateway is `.1`; the containers start at `.2`.
- A beta stack has no network of its own. It joins the network of its production
  stack as an external network and takes the next free addresses. Start the
  production stack first.

| Subnet           | Stack                                         | Network                     | Gateway       |
| :--------------- | :-------------------------------------------- | :-------------------------- | :------------ |
| `172.19.3.0/24`  | `uptime-kuma`, `uptime-kuma-beta`             | `uptime-kuma`               | `172.19.3.1`  |
| `172.20.1.0/24`  | `portainer`                                   | `portainer`                 | `172.20.1.1`  |
| `172.20.2.0/24`  | `watchtower`                                  | `watchtower`                | `172.20.2.1`  |
| `172.20.4.0/24`  | `netdata`                                     | `netdata`                   | `172.20.4.1`  |
| `172.20.5.0/24`  | `jellyfin`                                    | `jellyfin`                  | `172.20.5.1`  |
| `172.20.6.0/24`  | `freshrss`                                    | `freshrss`                  | `172.20.6.1`  |
| `172.20.7.0/24`  | `dockge`                                      | `dockge`                    | `172.20.7.1`  |
| `172.20.8.0/24`  | `xen-orchestra`                               | `xen-orchestra`             | `172.20.8.1`  |
| `172.20.9.0/24`  | `dozzle`                                      | `dozzle`                    | `172.20.9.1`  |
| `172.20.10.0/24` | `openspeedtest`                               | `openspeedtest`             | `172.20.10.1` |
| `172.20.11.0/24` | `netboot`                                     | `netboot`                   | `172.20.11.1` |
| `172.20.12.0/24` | `plex`                                        | `plex`                      | `172.20.12.1` |
| `172.20.14.0/24` | `cloudbeaver`                                 | `cloudbeaver`               | `172.20.14.1` |
| `172.20.15.0/24` | `adguard-home`                                | `adguard-home`              | `172.20.15.1` |
| `172.20.16.0/24` | `mariadb`                                     | `mariadb`                   | `172.20.16.1` |
| `172.20.17.0/24` | `pi-hole`                                     | `pi-hole`                   | `172.20.17.1` |
| `172.20.18.0/24` | `portainer-edge-agent`                        | `edge-agent`                | `172.20.18.1` |
| `172.20.19.0/24` | `unifi-network-application`                   | `unifi-network-application` | `172.20.19.1` |
| `172.20.20.0/24` | `nginx-proxy-manager`                         | `nginx-proxy-manager`       | `172.20.20.1` |
| `172.20.21.0/24` | `haproxy`                                     | `haproxy`                   | `172.20.21.1` |
| `172.20.22.0/24` | `it-tools`                                    | `it-tools`                  | `172.20.22.1` |
| `172.20.23.0/24` | `speedtest-tracker`, `speedtest-tracker-beta` | `speedtest-tracker`         | `172.20.23.1` |
| `172.20.24.0/24` | `immich`                                      | `immich`                    | `172.20.24.1` |
| `172.20.25.0/24` | `postgresql`                                  | `postgresql`                | `172.20.25.1` |
| `172.20.26.0/24` | `mini-qr`                                     | `mini-qr`                   | `172.20.26.1` |
| `172.20.27.0/24` | `harborguard`                                 | `harborguard`               | `172.20.27.1` |

`uptime-kuma` is an exception: it uses `172.19.3.0/24` instead of
`172.20.3.0/24`. The beta stacks use these addresses:

| Stack                    | Network             | Database      | App           |
| :----------------------- | :------------------ | :------------ | :------------ |
| `uptime-kuma`            | `uptime-kuma`       | `172.19.3.2`  | `172.19.3.3`  |
| `uptime-kuma-beta`       | `uptime-kuma`       | `172.19.3.4`  | `172.19.3.5`  |
| `speedtest-tracker`      | `speedtest-tracker` | `172.20.23.2` | `172.20.23.3` |
| `speedtest-tracker-beta` | `speedtest-tracker` | `172.20.23.4` | `172.20.23.5` |

To add a stack, pick a free `<n>` (for example `172.20.13.0/24` or
`172.20.28.0/24`) and check that no other network on the host uses it with
`docker network ls` and `docker network inspect`.

## Troubleshooting

| Problem                                              | Check                                                                                              |
| :--------------------------------------------------- | :------------------------------------------------------------------------------------------------- |
| The service is not reachable from the LAN            | Check `ports` in `compose.yml`, and that no other service uses the host port (`ss -tlnp`).         |
| The container has no internet access                 | Check `internal: false` and `enable_ip_masquerade: "true"`, and that the host has internet access. |
| Two stacks cannot reach each other                   | Each stack has its own network. Connect both to a shared external network, or publish a port.      |
| `Pool overlaps with other one on this address space` | Pick another subnet from the IP plan.                                                              |

See also the
[troubleshooting section](./choosing_a_network_driver.md#troubleshooting) of the
overview.
