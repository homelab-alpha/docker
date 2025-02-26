# Docker - Macvlan Network Setup

This document describes how to create a Docker network of type `macvlan`. This
network uses a specified IP range and offers various configuration options for
network settings.

## Command to Create the Network

Use the following command to create a Docker network of type `macvlan`:

```bash
sudo docker network create macvlan \
  --scope="local" \  # Restrict network to local communication
  --driver="macvlan" \  # Use macvlan driver for networking
  --ipam-driver="default" \  # Use default IPAM driver for IP management
  --ipam-opt= \  # (Optional) Specify custom IPAM options
  --subnet="192.168.1.0/24" \  # Set the subnet for the network
  --ip-range="192.168.1.128/25" \  # Specify range for containers
  --gateway="192.168.1.1" \  # Set the gateway IP
  --aux-address="web-server=192.168.1.2" \  # Assign static IPs for hosts
  --aux-address="db-server=192.168.1.3" \  # Assign static IPs for hosts
  --internal=false \  # Allow traffic to and from the internet
  --attachable=true \  # Allow containers to manually connect to the network
  --ingress=false \  # Not for use with Docker Swarm mode
  --config-from= \  # (Optional) Specify external config source
  --config-only=false \  # Ensure network and configuration are created
  --opt ipv6=disable \  # Disable IPv6 support
  --opt parent=eno1 \  # Bind to physical network interface eno1
  --label com.macvlan.network.description="is a non-isolated network."  # Custom network label
```

<br />

## Description of the Options

- `--scope="local"`: Limit the network to local communication.
  - **Example**: `--scope="local"` restricts the network to communication within
    a single host.
- `--driver="macvlan"`: Use the `macvlan` network driver.
  - **Example**: `--driver="macvlan"` specifies that the `macvlan` driver will
    be used to manage the network.
- `--ipam-driver="default"`: Use the default IPAM driver.
  - **Example**: `--ipam-driver="default"` uses Docker's default IP address
    management for allocating IPs.
- `--ipam-opt=`: Specify IPAM options (empty in this case).
  - **Example**: `--ipam-opt="subnet=192.168.1.0/24"` can be used to specify
    custom IPAM options, such as a custom subnet.
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
    This input assigns specific IP addresses (`192.168.1.2`, `192.168.1.3`) to
    `web-server` and `db-server`, ensuring they have static IPs within the
    network.
- `--internal=false`: Allow traffic to and from the internet.
  - **Example**: `--internal=false` allows external communication, enabling
    containers to access the internet.
- `--attachable=true`: Allow containers to connect to this network.
  - **Example**: `--attachable=true` lets containers manually connect to the
    network using `docker network connect`.
- `--ingress=false`: The network configuration is not intended for use with
  Docker Swarm mode.
  - **Example**: `--ingress=false` specifies that the network should not be used
    for Docker Swarm services.
- `--config-from=`: Specify an external configuration source (not used in this
  example).
  - **Example**: `--config-from="my_config"` can be used when a predefined
    configuration file is used to define the network settings.
- `--config-only=false`: Do not create just the configuration.
  - **Example**: `--config-only=false` ensures that both the network and the
    configuration are created.
- `--opt ipv6=disable`: Disable IPv6.
  - **Example**: `--opt ipv6=disable` disables IPv6 support, ensuring that only
    IPv4 is used.
- `--opt parent=eno1`: The physical network interface on which the network is
  based.
  - **Example**: `--opt parent=eno1` binds the network to the physical interface
    `eno1` on your host.
    - **How to find it**: Run `ip a` to list all network interfaces on the host.
      Look for the name of the active network interface that is connected to
      your local network (e.g., `eno1`, `eth0`, or `ens33`).
- `--label com.macvlan.network.description="is a non-isolated network."`: A
  label to describe the network.
  - **Example**:
    `--label com.macvlan.network.description="is a non-isolated network."` adds
    a custom label to describe the network for organizational purposes.

<br />

## Applications and Considerations

- **Macvlan Mode**: Using `macvlan` allows containers to communicate as separate
  devices on the network, with their own MAC addresses. This is beneficial when
  you want containers to appear as independent network devices.
- **Limitations**: Ensure the specified network interface (`eno1`) is available
  and suitable for use with Macvlan. Macvlan works by creating a virtual NIC for
  each container, so the physical interface must be capable of handling multiple
  MAC addresses.
- **Network Security**: By setting `--internal=false`, containers can
  communicate outside the network, which is important for applications that need
  internet access or need to interact with other devices on the network.

<br />

### Practical Example

To create a Docker network for a web application and a database, where the web
server (`web-server`) and database server (`db-server`) are assigned static IPs:

```bash
sudo docker network create macvlan \
  --scope="local" \
  --driver="macvlan" \
  --subnet="192.168.2.0/24" \
  --ip-range="192.168.2.128/25" \
  --gateway="192.168.2.1" \
  --aux-address="web-server=192.168.2.2" \
  --aux-address="db-server=192.168.2.3" \
  --internal=false \
  --attachable=true \
  --opt parent=eno1
```

This setup assigns specific IP addresses to `web-server` and `db-server`, and
ensures that containers can access the internet.

## Conclusion

Using a `macvlan` network in Docker allows containers to function as separate
devices with their own MAC addresses. This makes it suitable for applications
that need full integration with the physical network. Be mindful of network
interface availability and configuration to ensure proper operation.
