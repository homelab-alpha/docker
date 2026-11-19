# netboot.xyz - boot options

UEFI

```bash
netboot.xyz.efi
```

legacy

```bash
netboot.xyz.kpxe
```

## netboot.xyz Boot File Types

| File Type                         | Description                                                                    |
| --------------------------------- | ------------------------------------------------------------------------------ |
| **netboot.xyz.kpxe**              | Legacy DHCP boot image, uses built-in iPXE NIC drivers                         |
| **netboot.xyz-undionly.kpxe**     | Legacy DHCP boot image, recommended for devices with NIC issues                |
| **netboot.xyz.efi**               | UEFI boot image, uses built-in UEFI NIC drivers                                |
| **netboot.xyz-snp.efi**           | UEFI with Simple Network Protocol (SNP), attempts to boot all network devices  |
| **netboot.xyz-snponly.efi**       | UEFI with SNP, boots only from the device specified by a chainloader           |
| **netboot.xyz-arm64.efi**         | DHCP EFI boot image for ARM64, uses built-in iPXE NIC drivers                  |
| **netboot.xyz-arm64-snp.efi**     | UEFI with SNP for ARM64, attempts to boot all network devices                  |
| **netboot.xyz-arm64-snponly.efi** | UEFI with SNP for ARM64, boots only from the device specified by a chainloader |
| **netboot.xyz-rpi4-snp.efi**      | UEFI for Raspberry Pi 4, attempts to boot all network devices                  |
