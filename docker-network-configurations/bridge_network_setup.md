# Docker - Bridge Network Setup

This document describes how to create a Docker network of type `bridge`. This
network uses a specified IP range and offers various configuration options for
network settings.

## Docker

To create a custom `bridge` network in Docker with specific configurations, use
the following command:

```bash
sudo docker network create \
  --driver=bridge \  # Specifies the network driver to use (bridge in this case)
  --subnet=172.20.0.0/24 \  # Sets the subnet for the network (range of IP addresses)
  --ip-range=172.20.0.128/25 \  # Defines the range of IP addresses that can be assigned to containers
  --gateway=172.20.0.1 \  # Sets the gateway for the network
  --attachable=true \  # Allows containers outside the network to attach to it
  --internal=false \  # Allows external access to the network (set true for isolation)
  --external=false \  # Ensures the network is not externally exposed
  --opt "com.docker.network.bridge.default_bridge"="false" \  # Disables the default bridge network
  --opt "com.docker.network.bridge.enable_icc"="true" \  # Enables inter-container communication
  --opt "com.docker.network.bridge.enable_ip_masquerade"="true" \  # Allows IP masquerading for outbound traffic
  --opt "com.docker.network.bridge.host_binding_ipv4"="0.0.0.0" \  # Binds the host to all available IPv4 addresses
  --opt "com.docker.network.bridge.name"="change_me" \  # Custom name for the bridge (change to suit your needs)
  --opt "com.docker.network.driver.mtu"="1500" \  # Sets the MTU (Maximum Transmission Unit)
  --label "com.change_me.network.description"="is an isolated bridge network." \  # Label for network description
  change_me_net  # Name of the network being created (change to a meaningful name)
```

<br />

## Docker Compose

Use the following YAML configuration to create a Docker network of type `bridge`:

```yml
---
networks:
  change_me:
    attachable: false # Containers cannot connect to this network manually.
    internal: false # Allows traffic to and from the internet.
    external: false # The network is not externally managed.
    name: change_me # The name of the network.
    driver: bridge # Use the bridge driver for networking.
    ipam: # IP Address Management settings.
      driver: default # Use the default IPAM driver.
      config:
        - subnet: 172.20.0.0/24 # Network's subnet.
          ip_range: 172.20.0.128/25 # Range of available IP addresses.
          gateway: 172.20.0.1 # Gateway IP address.
    driver_opts: # Network driver configuration options.
      com.docker.network.bridge.default_bridge: "false" # Disable default bridge network.
      com.docker.network.bridge.enable_icc: "true" # Enable inter-container communication (ICC).
      com.docker.network.bridge.enable_ip_masquerade: "true" # Enable IP masquerading for internet access.
      com.docker.network.bridge.host_binding_ipv4: "0.0.0.0" # Allow connections from any IP address.
      com.docker.network.bridge.name: "change_me" # Custom bridge network name.
      com.docker.network.driver.mtu: "1500" # Maximum Transmission Unit for the network.
    labels: # Network label for description.
      com.change_me.network.description: "is an isolated bridge network."
```

<br />

## Description of the Options

- **`internal: false`**: Allows traffic to and from the internet.
  - **Example**: `internal: false` enables external communication, allowing
    containers to access the internet. Setting it to `true` restricts containers
    to internal communication only, useful for isolated applications that do not
    need external access.
- **`name: change_me`**: The name of the network.
  - **Example**: `name: change_me` specifies the network's name, which Docker
    uses to identify it.
- **`driver: bridge`**: Specifies the use of the `bridge` network driver.
  - **Example**: `driver: bridge` tells Docker to use the `bridge` driver to
    manage the network.
- **`ipam`**: IPAM (IP Address Management) settings for the network.
  - **Example**:
    ```yml
    ipam:
      driver: default
      config:
        - subnet: 172.20.0.0/24
          ip_range: 172.20.0.128/25
          gateway: 172.20.0.1
    ```
    This section defines the network's subnet, IP range, and gateway.
- **`driver_opts`**: Options for configuring the network driver.
  - **Example**:
    ```yml
    driver_opts:
      com.docker.network.bridge.default_bridge: "false" # Disables the default bridge network.
      com.docker.network.bridge.enable_icc: "true" # Enables inter-container communication (ICC).
      com.docker.network.bridge.enable_ip_masquerade: "true" # Enables IP masquerading, allowing containers to access the external network.
      com.docker.network.bridge.host_binding_ipv4: "0.0.0.0" # Allows connections to the host from any IP address.
      com.docker.network.bridge.name: "change_me" # Specifies the custom bridge network name.
      com.docker.network.driver.mtu: "1500" # Sets the maximum transmission unit for the network.
    ```
    This includes options like disabling the default bridge, enabling
    inter-container communication (ICC), and configuring IP masquerading.
- **`labels`**: Adds labels for the network.
  - **Example**:
    `com.change_me.network.description: "is an isolated bridge network."`
    adds a description label for the network. This label can be used for
    identifying the network or for documentation purposes.

<br />

## Applications and Considerations

- **Bridge Network**: The `bridge` network is a default Docker network that
  allows containers to communicate with each other via virtual Ethernet
  interfaces. It is ideal for cases where you need an isolated network for
  containers but still want them to have the ability to communicate with each
  other.

- **Limitations**: The `bridge` network is isolated, meaning containers within
  the same network can communicate with each other, but they cannot access other
  networks unless explicitly configured. This isolation ensures that containers
  are not exposed to external networks by default.

- **Network Security**: By setting `internal: false`, containers can communicate
  with the external network, which is crucial for containers needing internet
  access. However, users should be mindful of security when allowing external
  communication. For enhanced security, consider using firewalls or additional
  network isolation measures to protect sensitive applications.

<br />

## Conclusion

Using a `bridge` network in Docker provides an easy way to connect containers
within an isolated network. You have the flexibility to grant internet access as
required, while maintaining control over the network's configuration through
options like IP address management and driver settings.
