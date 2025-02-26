# Docker - IPvlan Network Setup

This document describes how to create a Docker network of type `ipvlan`. This
network uses a specified IP range and offers various configuration options for
network settings.

## Command to Create the Network

Use the following Docker command to create the `ipvlan` network:

```bash
sudo docker network create ipvlan \
  --scope="local" \  # Restrict network to local communication
  --driver="ipvlan" \  # Use ipvlan driver for networking
  --ipam-driver="default" \  # Use default IPAM driver for IP management
  --ipam-opt="" \  # (Optional) Custom IPAM options
  --subnet="192.168.1.0/24" \  # Set the subnet for the network
  --ip-range="192.168.1.128/25" \  # Specify range for containers
  --gateway="192.168.1.1" \  # Set the gateway IP
  --aux-address="web-server=192.168.1.2" \  # Assign static IPs for hosts
  --aux-address="db-server=192.168.1.3" \  # Assign static IPs for hosts
  --internal=false \  # Allow traffic to and from the internet
  --attachable=true \  # Allow containers to manually connect to the network
  --ingress=false \  # Not for use with Docker Swarm mode
  --config-from= \  # (Optional) Specify external config source
  --config-only=false \  # Ensure network and config are created
  --opt ipv6=disable \  # Disable IPv6 support
  --opt ipvlan_mode=l2 \  # Use Layer 2 mode for communication
  --opt parent=eno1 \  # Bind to the physical network interface eno1
  --label com.ipvlan.network.description="is a non-isolated network."  # Custom network label
```

<br />

## Description of the Options

- `--scope="local"`: Limit the network to local communication.
  - **Example**: `--scope="local"` restricts the network to communication within
    a single host.
- `--driver="ipvlan"`: Use the `ipvlan` network driver.
  - **Example**: `--driver="ipvlan"` specifies that the `ipvlan` driver will be
    used to manage the network.
- `--ipam-driver="default"`: Use the default IPAM driver.
  - **Example**: `--ipam-driver="default"` uses Docker's default IP address
    management for allocating IPs.
- `--ipam-opt=""`: Specify IPAM options (empty in this case).
  - **Example**: `--ipam-opt="subnet=192.168.1.0/24"` can be used to specify
    custom IPAM options like a custom subnet.
- `--subnet="192.168.1.0/24"`: The subnet for the network.
  - **Example**: `--subnet="192.168.1.0/24"` defines the range of IP addresses
    that will be used by the network.
- `--ip-range="192.168.1.128/25"`: The range of available IP addresses for
  containers.
  - **Example**: `--ip-range="192.168.1.128/25"` ensures containers only use IP
    addresses between `192.168.1.128` and `192.168.1.255`.
- `--gateway="192.168.1.1"`: The IP address of the network gateway.
  - **Example**: `--gateway="192.168.1.1"` specifies the gateway IP that
    containers will use to access the outside network.
- `--aux-address`: Specify specific IP addresses for hosts within the network.
  - **Example**:
    ```bash
    --aux-address="web-server=192.168.1.2"
    --aux-address="db-server=192.168.1.3"
    ```
    These entries assign specific IP addresses (`192.168.1.2`, `192.168.1.3`) to
    `web-server` and `db-server`, ensuring they have static IPs within the
    network.
- `--internal=false`: Allow traffic to and from the internet.
  - **Example**: `--internal=false` enables external communication, allowing
    containers to access the internet.
- `--attachable=true`: Allow containers to connect to this network.
  - **Example**: `--attachable=true` lets containers manually connect to the
    network via `docker network connect`.
- `--ingress=false`: The network configuration is not intended for use with
  Docker's Swarm mode.
  - **Example**: `--ingress=false` specifies that the network should not be used
    for Docker Swarm services.
- `--config-from=`: Specify an external configuration source (not used in this
  example).
  - **Example**: `--config-from="my_config"` could be used when using a
    predefined configuration file to define the network settings.
- `--config-only=false`: Not only create a configuration.
  - **Example**: `--config-only=false` ensures that both the network and its
    configuration are created.
- `--opt ipv6=disable`: Disable IPv6.
  - **Example**: `--opt ipv6=disable` turns off IPv6 support, ensuring only IPv4
    is used.
- `--opt ipvlan_mode=l2`: Use Layer 2 mode for the network.
  - **Example**: `--opt ipvlan_mode=l2` specifies that containers should
    communicate at the data link layer (Layer 2), similar to regular Ethernet
    devices.
- `--opt parent=eno1`: The physical network interface on which the network is
  based.
  - **Example**: `--opt parent=eno1` binds the network to the physical interface
    `eno1` on your host.
    - **How to find it**: Run `ip a` to list all network interfaces on the host.
      Look for the name of the active network interface connected to your local
      network (e.g., `eno1`, `eth0`, or `ens33`).
- `--label com.ipvlan.network.description="is a non-isolated network."`: A label
  to describe the network.
  - **Example**:
    `--label com.ipvlan.network.description="is a non-isolated network."` adds a
    custom label to help describe the network for organizational purposes.

<br />

## Applications and Considerations

- **IPvlan Mode (L2)**: Using `ipvlan_mode=l2` allows containers to communicate
  as peers on the same physical network.
- **Limitations**: Ensure the specified network interface (`eno1`) is available
  and suitable for use with IPvlan. Verify it is up and properly configured.
- **Network Security**: By setting `--internal=false`, containers can
  communicate outside the network, which is important for applications that
  require internet access.

<br />

### Practical Example

To create a Docker network for a web application and a database, where the web
server (`web-server`) and database server (`db-server`) are assigned static IPs:

```bash
sudo docker network create ipvlan \
  --scope="local" \
  --driver="ipvlan" \
  --subnet="192.168.2.0/24" \
  --ip-range="192.168.2.128/25" \
  --gateway="192.168.2.1" \
  --aux-address="web-server=192.168.2.2" \
  --aux-address="db-server=192.168.2.3" \
  --internal=false \
  --attachable=true \
  --opt ipvlan_mode=l2 \
  --opt parent=eno1
```

This setup assigns specific IP addresses to `web-server` and `db-server` while
ensuring the containers can access the internet.

<br />

## Conclusion

Using an `ipvlan` network in Docker offers benefits such as low-level network
communication and IP address management. This is especially useful when
containers need to function as 'peers' on the same physical network. However, be
mindful of network interface availability and configuration. By understanding
and configuring the various options, you can create a robust and flexible
network tailored to your Docker containers.
