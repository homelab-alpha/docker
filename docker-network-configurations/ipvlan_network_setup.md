# Docker - IPvlan Network Setup

An `ipvlan` network gives each container its own IP address on your network,
while all containers share the MAC address of the host interface (the _parent_).
Use it when a container must be reachable on its own address, but your switch,
access point, or hypervisor limits the number of MAC addresses per port. The
driver needs Linux kernel 4.2 or later.

See [Choosing a network driver](./choosing_a_network_driver.md) for a comparison
with `bridge` and `macvlan`.

IPvlan has two modes:

- **L2** (the default): the containers join the LAN of the parent interface.
  They use the router of your LAN as gateway.
- **L3**: the containers get their own subnet, and the Docker host routes it.
  Broadcast and multicast are dropped, so your router needs a route to that
  subnet.

The examples use this LAN:

| Setting                   | Value                                   |
| :------------------------ | :-------------------------------------- |
| LAN subnet                | `192.168.1.0/24`                        |
| Router (gateway)          | `192.168.1.1`                           |
| Parent interface          | `eth0` (check yours with `ip -br link`) |
| Addresses for containers  | `192.168.1.192/27` (`.192` to `.223`)   |
| Address for the host shim | `192.168.1.223`                         |

> [!IMPORTANT]
>
> Keep the container range outside the DHCP pool of your router, so that no
> other device gets one of these addresses.

## L2 Mode

### Create the Network with the CLI

Create the network once, outside the stacks, so that `docker compose down` does
not remove it:

```bash
docker network create \
  --driver ipvlan \
  --subnet 192.168.1.0/24 \
  --gateway 192.168.1.1 \
  --ip-range 192.168.1.192/27 \
  --aux-address host-shim=192.168.1.223 \
  --opt parent=eth0 \
  --opt ipvlan_mode=l2 \
  --label com.ipvlan.network.description="is an ipvlan network on the LAN." \
  ipvlan
```

- `--ip-range` limits the addresses that Docker hands out.
- `--aux-address` reserves an address, here for the
  [host shim](#reach-the-containers-from-the-host).

### Use the Network in a Stack

```yaml
networks:
  ipvlan:
    external: true
    name: ipvlan

services:
  example_app:
    image: docker.io/library/nginx:stable
    networks:
      ipvlan:
        ipv4_address: 192.168.1.200
```

The service is now reachable at `http://192.168.1.200` from your LAN. `ports`
has no effect on this network: every port that the container listens on is
reachable.

### Define the Network in Compose

You can also define the network in `compose.yml`. Docker Compose then removes it
on `docker compose down`:

```yaml
networks:
  ipvlan:
    name: ipvlan
    driver: ipvlan
    driver_opts:
      parent: eth0
      ipvlan_mode: l2
    ipam:
      config:
        - subnet: 192.168.1.0/24
          gateway: 192.168.1.1
          ip_range: 192.168.1.192/27
          aux_addresses:
            host-shim: 192.168.1.223
```

## L3 Mode

In L3 mode, the containers use a subnet that is not your LAN, for example
`10.10.10.0/24`. The Docker host acts as the router for it. `--gateway` is not
used in this mode.

```bash
docker network create \
  --driver ipvlan \
  --subnet 10.10.10.0/24 \
  --opt parent=eth0 \
  --opt ipvlan_mode=l3 \
  ipvlan-l3
```

Add a static route on your router, so that the LAN can reach the containers:

| Destination     | Next hop                           |
| :-------------- | :--------------------------------- |
| `10.10.10.0/24` | The LAN address of the Docker host |

Without this route, only the containers on the host can reach each other.

## VLANs

Use a parent such as `eth0.20` to put the network on VLAN 20. Docker creates the
sub-interface and removes it again with `docker network rm`. The switch port of
the host must carry that VLAN (a trunk port).

```bash
docker network create \
  --driver ipvlan \
  --subnet 192.168.20.0/24 \
  --gateway 192.168.20.1 \
  --opt parent=eth0.20 \
  ipvlan20
```

## IPv6

Add an IPv6 subnet of your LAN next to the IPv4 subnet:

```bash
docker network create \
  --driver ipvlan --ipv6 \
  --subnet 192.168.1.0/24 --gateway 192.168.1.1 --ip-range 192.168.1.192/27 \
  --subnet 2001:db8:1::/64 --gateway 2001:db8:1::1 \
  --opt parent=eth0 \
  ipvlan
```

Replace `2001:db8:1::/64` (a documentation prefix) with the IPv6 prefix of your
LAN. In Compose, add `enable_ipv6: true` and a second entry under `ipam.config`.

## Reach the Containers from the Host

Linux blocks traffic between the parent interface and its IPvlan containers. The
host cannot reach the containers, and the containers cannot reach the host,
while other devices on the LAN can. To fix this, add an IPvlan interface (a
_shim_) on the host, on the same parent, with the reserved address:

```bash
sudo ip link add ipvlan-shim link eth0 type ipvlan mode l2
sudo ip addr add 192.168.1.223/32 dev ipvlan-shim
sudo ip link set ipvlan-shim up
sudo ip route add 192.168.1.192/27 dev ipvlan-shim
```

These commands do not survive a reboot. Add them to the network configuration of
the host (for example systemd-networkd or NetworkManager) to make them
permanent.

## Troubleshooting

| Problem                                         | Check                                                                                       |
| :---------------------------------------------- | :------------------------------------------------------------------------------------------ |
| The host cannot reach the container             | Expected: add the [host shim](#reach-the-containers-from-the-host).                         |
| The LAN cannot reach the container              | Check `parent`, the subnet, and the gateway; in L3 mode, check the route on the router.     |
| Two devices use the same IP address             | Move the container range out of the DHCP pool of the router.                                |
| `docker network create` fails                   | Check that the parent interface exists (`ip -br link`) and that the kernel supports IPvlan. |
| Your router shows many IP addresses for one MAC | Expected with IPvlan; use `macvlan` if you need a MAC address per container.                |

See also the
[troubleshooting section](./choosing_a_network_driver.md#troubleshooting) of the
overview.
