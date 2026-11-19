# Docker - Macvlan Network Setup

A `macvlan` network makes each container a separate device on your network, with
its own MAC address and IP address. Use it when a container must look like a
real host on the LAN, for example a DHCP server, or an app that finds devices
with broadcasts.

See [Choosing a network driver](./choosing_a_network_driver.md) for a comparison
with `bridge` and `ipvlan`.

> [!IMPORTANT]
>
> The network interface of the host and your switch must accept several MAC
> addresses on one port (promiscuous mode). Many Wi-Fi interfaces and some
> hypervisors (for example with MAC filtering on the virtual switch) do not. Use
> `ipvlan` in that case.

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

## Create the Network with the CLI

Create the network once, outside the stacks, so that `docker compose down` does
not remove it:

```bash
docker network create \
  --driver macvlan \
  --subnet 192.168.1.0/24 \
  --gateway 192.168.1.1 \
  --ip-range 192.168.1.192/27 \
  --aux-address host-shim=192.168.1.223 \
  --opt parent=eth0 \
  --opt macvlan_mode=bridge \
  --label com.macvlan.network.description="is a macvlan network on the LAN." \
  macvlan
```

- `--ip-range` limits the addresses that Docker hands out.
- `--aux-address` reserves an address, here for the
  [host shim](#reach-the-containers-from-the-host).
- `macvlan_mode=bridge` (the default) lets containers on the same parent talk to
  each other directly.

## Use the Network in a Stack

```yaml
networks:
  macvlan:
    external: true
    name: macvlan

services:
  example_app:
    image: docker.io/library/nginx:stable
    networks:
      macvlan:
        ipv4_address: 192.168.1.201
    mac_address: 02:42:c0:a8:01:c9
```

The service is now reachable at `http://192.168.1.201` from your LAN. `ports`
has no effect on this network: every port that the container listens on is
reachable.

`mac_address` is optional. A fixed MAC address keeps the same entry in your
router (for example a DHCP reservation or a firewall rule) when the container is
recreated. Use a locally administered address, which starts with `02`.

## Define the Network in Compose

You can also define the network in `compose.yml`. Docker Compose then removes it
on `docker compose down`:

```yaml
networks:
  macvlan:
    name: macvlan
    driver: macvlan
    driver_opts:
      parent: eth0
      macvlan_mode: bridge
    ipam:
      config:
        - subnet: 192.168.1.0/24
          gateway: 192.168.1.1
          ip_range: 192.168.1.192/27
          aux_addresses:
            host-shim: 192.168.1.223
```

## VLANs

Use a parent such as `eth0.20` to put the network on VLAN 20 (802.1Q trunk
mode). Docker creates the sub-interface and removes it again with
`docker network rm`. The switch port of the host must carry that VLAN.

```bash
docker network create \
  --driver macvlan \
  --subnet 192.168.20.0/24 \
  --gateway 192.168.20.1 \
  --opt parent=eth0.20 \
  macvlan20
```

## IPv6

Add an IPv6 subnet of your LAN next to the IPv4 subnet:

```bash
docker network create \
  --driver macvlan --ipv6 \
  --subnet 192.168.1.0/24 --gateway 192.168.1.1 --ip-range 192.168.1.192/27 \
  --subnet 2001:db8:1::/64 --gateway 2001:db8:1::1 \
  --opt parent=eth0 \
  macvlan
```

Replace `2001:db8:1::/64` (a documentation prefix) with the IPv6 prefix of your
LAN. In Compose, add `enable_ipv6: true` and a second entry under `ipam.config`.

## Reach the Containers from the Host

Linux blocks traffic between the parent interface and its macvlan containers.
The host cannot reach the containers, and the containers cannot reach the host,
while other devices on the LAN can. To fix this, add a macvlan interface (a
_shim_) on the host, on the same parent, with the reserved address:

```bash
sudo ip link add macvlan-shim link eth0 type macvlan mode bridge
sudo ip addr add 192.168.1.223/32 dev macvlan-shim
sudo ip link set macvlan-shim up
sudo ip route add 192.168.1.192/27 dev macvlan-shim
```

These commands do not survive a reboot. Add them to the network configuration of
the host (for example systemd-networkd or NetworkManager) to make them
permanent.

Another option is to connect the container to a `bridge` network as well, and
let the host reach it through that network.

## Troubleshooting

| Problem                               | Check                                                                                           |
| :------------------------------------ | :---------------------------------------------------------------------------------------------- |
| The host cannot reach the container   | Expected: add the [host shim](#reach-the-containers-from-the-host).                             |
| The LAN cannot reach the container    | Check `parent`, the subnet, and the gateway, and that the switch accepts several MAC addresses. |
| It works on a cable, not on Wi-Fi     | Most Wi-Fi interfaces do not accept extra MAC addresses; use `ipvlan`.                          |
| It does not work in a virtual machine | Allow promiscuous mode or MAC address changes on the virtual switch, or use `ipvlan`.           |
| Two devices use the same IP address   | Move the container range out of the DHCP pool of the router.                                    |

See also the
[troubleshooting section](./choosing_a_network_driver.md#troubleshooting) of the
overview.
